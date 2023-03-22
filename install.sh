#!/bin/sh
# TODO: Add color support
# TODO: Add yes no prompts for dangerous operations

sudo apt update && yes | sudo apt upgrade && yes | sudo apt autoremove
# install requirements
yes | sudo apt install build-essential lynx procps file git stow
cd

git clone https://www.github.com/UnrealApex/dotfiles.git "$HOME"/.dotfiles
cd "$HOME"/.dotfiles

mv -f ~/.bashrc ~/.bashrc.bak 2>/dev/null
mv -f ~/.tmux.conf ~/.tmux.conf.bak 2>/dev/null
mv -f ~/Brewfile ~/Brewfile.bak 2>/dev/null
mv -f ~/.gitconfig ~/.gitconfig.bak 2>/dev/null
mv -f ~/.vimrc ~/.vimrc.bak 2>/dev/null
mf -f ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# setting up symlinks
echo "Creating symlinks..."
stow */

# TODO: remove files already present

# homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
echo "Adding Homebrew to path..."
grep -qsF 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' ~/.profile || (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ~/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# install from brewfile
brew bundle install --file=~/Brewfile

# set up jetbrains mono nerd font
if [ ! -f "/usr/share/fonts/truetype/JetBrains Mono Nerd Font Complete Regular.ttf" ]; then
  echo "Installing nerd font..."
  # make sure font directory exists
  mkdir -p /usr/share/fonts/truetype/
  cd /usr/share/fonts/truetype
  sudo curl -fLo "JetBrains Mono Nerd Font Complete Regular.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Nerd%20Font%20Complete%20Regular.ttf
  echo "Nerd Font installed"
  cd ~
  else
    echo "Nerd Font already installed, skipping..."
fi

# google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& sudo apt -y --fix-missing install ./google-chrome*.deb \
&& sudo apt-get -y install -f

# anaconda
echo "Installing Anaconda..."
echo "You will need to accept its licence agreement to install it"

# download install script from anaconda website and run it
lynx \
    --listonly \
    --nonumbers  \
    --dump https://www.anaconda.com/products/distribution |
    grep -m1 -F 'Linux-x86_64.sh' |
    xargs wget -O anaconda-installer.sh
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

> ~/.gitconfig_local
echo "[user]" >> ~/.gitconfig_local
eval "echo \"  name = ${commitname}\" >> ~/.gitconfig_local"
eval "echo \"  email = ${commitemail}\" >> ~/.gitconfig_local"
echo "Created file ~/.gitconfig_local with commit information"

# authenticate to GitHub
gh auth login --web

printf "\n\nDotfiles installed!\n\n"

# show system information once finished
neofetch
