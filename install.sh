#!/bin/sh
# TODO: Add color support
# TODO: Add yes no prompts for dangerous operations

sudo apt update
# install requirements
yes | sudo apt install build-essential procps file git stow
cd ~

git clone https://www.github.com/UnrealApex/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
mkdir -p ~/.dotfiles-backup

mv -f ~/.bashrc ~/.dotfiles-backup/.bashrc 2>/dev/null
mv -f ~/Brewfile ~/.dotfiles-backup/Brewfile 2>/dev/null
mv -f ~/.gitconfig ~/.dotfiles-backup/.gitconfig 2>/dev/null
# setting up symlinks
echo "Creating symlinks..."
stow */

# TODO: remove files already present

# homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
echo "Adding Homebrew to path..."
grep -qsF 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' ~/.bashrc || (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> "${HOME}"/.bashrc
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
echo "Created file ~/.config/.gitconfig_local with commit information"

# anaconda
# source <(curl -s https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh)

printf "\n\nDotfiles installed!\n\n"

# show system information once finished
neofetch
