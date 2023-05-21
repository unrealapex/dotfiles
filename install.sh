#!/bin/bash
# TODO: Add color support
# TODO: Add yes no prompts for dangerous operations

# make sure script is not run as the root user
if [[ "$(id -u)" -eq 0 ]] 
then
  printf "%s\n" "please do not run this script as root" >&2  
  exit 1
fi

sudo pacman -Syu --noconfirm
sudo pacman -S git --noconfirm

cd

git clone https://gitlab.com/unrealapex/dotfiles.git "$HOME"/.dotfiles && cd "$HOME"/.dotfiles || echo "could not clone dotfiles repository" && exit 1

# yay
mkdir --parents ~/Downloads/git
cd ~/Downloads/git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
yes | makepkg -si

# enable multilib
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

sudo pacman -Syu --noconfirm

# install packages
yay -S --noconfirm --needed - < packages


backup_paths=(
  ~/.bash_profile
  ~/.bashrc
  ~/.config/betterlockscreen
  ~/.config/bspwm
  ~/.config/dunst
  ~/.config/flameshot
  ~/.config/fontconfig/conf.d/01-emoji.conf
  ~/.config/kitty
  ~/.config/lf
  ~/.config/nvim
  ~/.config/picom
  ~/.config/polybar
  ~/.gitconfig
  ~/.gitconfig_local
  ~/.tmux.conf
  ~/.vimrc
  ~/.xinitrc
)

for path in "${backup_paths[@]}"
do
  mv --force $path $path.bak 2>/dev/null
done

# setting up symlinks
echo "Creating symlinks..."
stow */

# create default user directories
xdg-user-dirs-update

# install neovim plugins
# TODO: check if Mason language servers get installed too
nvim --headless "+Lazy! sync" +qa

# install jetbrains mono nerd font
if [ ! -f "/usr/share/fonts/truetype/JetBrains Mono Nerd Font Complete Regular.ttf" ]; then
  echo "Installing nerd font..."
  # make sure font directory exists
  sudo mkdir --parents /usr/share/fonts/truetype/
  cd /usr/share/fonts/truetype
  sudo curl --fail --location --output "JetBrains Mono Nerd Font Complete Regular.ttf" \
  https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf?raw=true
  sudo fc-cache -fv
  echo "Nerd Font installed"
  cd
  else
    echo "Nerd Font already installed, skipping..."
fi

# anaconda
echo "Installing Anaconda..."
echo "You will need to accept its licence agreement to install it"

# download install script from anaconda website and run it
lynx \
    --listonly \
    --nonumbers  \
    --dump https://www.anaconda.com/products/distribution |
    grep -m1 --fixed-strings 'Linux-x86_64.sh' |
    xargs wget --output-document anaconda-installer.sh && \
# execute like this to prevent errors since script is interactive
chmod +x anaconda-installer.sh && \
./anaconda-installer.sh && \
rm anaconda-installer.sh && \
conda config --set auto_activate_base false

# install betterfox's fastfox and smoothfox user.js and merge it into one file
curl -o user.js https://raw.githubusercontent.com/yokoffing/Betterfox/master/Fastfox.js && \
curl https://raw.githubusercontent.com/yokoffing/Betterfox/master/Smoothfox.js >> user.js  && \
# ensure profiles directory is created
sleep 10 && killall firefox &
firefox -headless &
wait 
# move user.js to default firefox profile
mv user.js "$(find ~/.mozilla/firefox/ -type d -name "*.default-release")"


# cache lockscreen image
betterlockscreen --update ~/.dotfiles/sakura.png

# set up Git commit information
echo "Setting Git commit information..."
echo -n "Enter the email address you want to use for commits: "
read commitemail
echo -n "Enter the name you want to use for commits: "
read commitname


if [ ! -z "$commitemail" ] && [ ! -z "$commitname" ]
then
  echo "[user]" > ~/.gitconfig_local
  eval "echo \"  name = ${commitname}\" >> ~/.gitconfig_local"
  eval "echo \"  email = ${commitemail}\" >> ~/.gitconfig_local"
  echo "Created file ~/.gitconfig_local with commit information"
else
  echo "Git commit credentials not provided, skipped"
fi

# services
sudo systemctl enable mpd.service

printf "\n\nDotfiles installed!\n\n"

# show system information once finished installing
neofetch
