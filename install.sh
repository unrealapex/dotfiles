#!/bin/sh
# TODO: Add color support
# TODO: Add yes no prompts for dangerous operations

sudo apt update
# install requirements
yes | sudo apt install build-essential procps file git stow
cd ~

git clone https://www.github.com/UnrealApex/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
stow */

mkdir -p .dotfiles-backup
# TODO: remove files already present

mv -f ~/.bashrc ~/.dotfiles-backup/.bashrc
mv -f ~/Brewfile ~/.dotfiles-backup/Brewfile
mv -f ~/.gitconfig ~/.dotfiles-backup/.gitconfig

# create symlinks
ln -s .bashrc ~/.bashrc
ln -s Brewfile ~/Brewfile
ln -s .gitconfig ~/.gitconfig

# homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
echo "Adding Homebrew to path..."
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> "${HOME}"/.profile
# FIXME: figure out why this is not evaluating properly
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# install from brewfile
brew bundle install

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

# set up git commit information
echo "Setting up Git..."
echo "Setting commit information..."
echo -n "Enter the email address you want to use for commits: "
read commitemail
echo -n "Enter the name you want to use for commits: "
read commitname

> ~/.gitconfig_local
echo "[user]" >> ~/.gitconfig_local
eval "echo \"  name = ${commitname}\" >> ~/.gitconfig_local"
eval "echo \"  email = ${commitemail}\" >> ~/.gitconfig_local"


# anaconda
# source <(curl -s https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh)

printf "\n\nDotfiles installed!\n\n"
# TODO: add ascii art
