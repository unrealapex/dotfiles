#!/bin/sh
# TODO: Add color support
# TODO: Add yes no prompts for dangerous operations

sudo pacman -Syu --noconfirm

cd

git clone https://www.gitlab.com/unrealapex/dotfiles.git -b arch "$HOME"/.dotfiles && cd "$HOME"/.dotfiles || exit 1


# install packages
sudo pacman -S --noconfirm --needed - < packages

backup() {
  if [ -f $1 ]
  then
    echo "Conflicting file found, moving it to $1.bak"
    mv --force $1 $1.bak 2>/dev/null

  # handle directories
  elif [ -d $1 ]
  then
    mv --force --resursive $1 $1.bak 2>/dev/null
    echo "Conflicting directory found, moving it to $1.bak"
  else
    echo "Unable to backup conflicting file/directory $1"
  fi
}

backup ~/.bashrc
backup ~/.tmux.conf
backup ~/.gitconfig
backup ~/.vimrc
backup ~/.config/nvim
backup ~/.config/i3
backup ~/.config/picom
backup ~/.config/kitty

# setting up symlinks
echo "Creating symlinks..."
stow */

# install jetbrains mono nerd font
if [ ! -f "/usr/share/fonts/truetype/JetBrains Mono Nerd Font Complete Regular.ttf" ]; then
  echo "Installing nerd font..."
  # make sure font directory exists
  sudo mkdir --parents /usr/share/fonts/truetype/
  cd /usr/share/fonts/truetype
  sudo curl --fail --location --output "JetBrains Mono Nerd Font Complete Regular.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Nerd%20Font%20Complete%20Regular.ttf
  fc-cache -fv
  echo "Nerd Font installed"
  cd
  else
    echo "Nerd Font already installed, skipping..."
fi

# TODO: add multilib repository for steam

# anaconda
echo "Installing Anaconda..."
echo "You will need to accept its licence agreement to install it"

# download install script from anaconda website and run it
lynx \
    --listonly \
    --nonumbers  \
    --dump https://www.anaconda.com/products/distribution |
    grep -m1 --fixed-strings 'Linux-x86_64.sh' |
    xargs wget --output-document anaconda-installer.sh
# execute like this to prevent errors since script is interactive
chmod +x anaconda-installer.sh
./anaconda-installer.sh
rm anaconda-installer.sh

# set up Git commit information
echo "Setting Git commit information..."
echo -n "Enter the email address you want to use for commits: "
read commitemail
echo -n "Enter the name you want to use for commits: "
read commitname

echo "[user]" > ~/.gitconfig_local
eval "echo \"  name = ${commitname}\" >> ~/.gitconfig_local"
eval "echo \"  email = ${commitemail}\" >> ~/.gitconfig_local"
echo "Created file ~/.gitconfig_local with commit information"

# services
# start lightdm on boot
sudo systemctl enable lightdm.service


printf "\n\nDotfiles installed!\n\n"

# show system information once finished installing
neofetch
