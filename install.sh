#!/bin/sh
# TODO: Add color support
# TODO: Add yes no prompts for dangerous operations
cd ~
# add config alias to bashrc if it is not already present
grep -qsF "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" ~/.bashrc || echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> ~/.bashrc
# add .cfg folder to gitignore if it is not already present
grep -qsF .cfg ~/.gitignore || echo ".cfg" >> ~/.gitignore

git clone --bare https://www.github.com/UnrealApex/dotfiles.git $HOME/.cfg

config() {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config...";
  else
    echo "Moving dotfiles preventing checkout to ~/.config-backup...";
  config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
echo "Checking out .cfg..."
config checkout
config config --local status.showUntrackedFiles no


# homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ${HOME}/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

sudo apt update
sudo apt-get install build-essential

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
