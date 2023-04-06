#!/bin/sh
# TODO: Add color support
# TODO: Add yes no prompts for dangerous operations

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

cd

# TODO: change this to GitLab repo?
git clone https://www.github.com/UnrealApex/dotfiles.git "$HOME"/.dotfiles
cd "$HOME"/.dotfiles || exit

# install packages
sudo apt install -y "$(cat packages)"

# TODO: display different message depending on whether a file or directory is
# given
backup() {
  if [ -f $1 ]
  then
    mv --force $1 $1.bak 2>/dev/null
  # handle directories
  elif [ -d $1 ]
  then
    mv --force --resursive $1 $1.bak 2>/dev/null
  else
    echo "Unable to backup conflicting file/directory"
  fi
  echo "Conflicting file/directory found, moving it to $1.bak"
}

backup ~/.bashrc
backup ~/.tmux.conf
backup ~/.gitconfig
backup ~/.vimrc
backup ~/.config/nvim

# setting up symlinks
echo "Creating symlinks..."
stow */

# TODO: remove files already present

# homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
echo "Adding Homebrew to path..."
grep --quiet --no-messages --fixed-strings 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' ~/.profile || (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ~/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# install some packages from Homebrew
brew install asciinema
brew install cmatrix
brew install gh
brew install git-delta
brew install glow
brew install hyperfine
brew install lua
brew install neovim
brew install node
brew install openjdk

# don't install things specific to Linux GUI setup if running on WSL
if [[ ! $(grep --no-messages Microsoft /proc/version) ]]; then

  # set up jetbrains mono nerd font
  if [ ! -f "/usr/share/fonts/truetype/JetBrains Mono Nerd Font Complete Regular.ttf" ]; then
    echo "Installing nerd font..."
    # make sure font directory exists
    mkdir --parents /usr/share/fonts/truetype/
    cd /usr/share/fonts/truetype
    sudo curl --fail --location --output "JetBrains Mono Nerd Font Complete Regular.ttf" \
    https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Nerd%20Font%20Complete%20Regular.ttf
    fc-cache -fv
    echo "Nerd Font installed"
    cd
    else
      echo "Nerd Font already installed, skipping..."
  fi
  
  # spotify
  curl --silent --show-error https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt install -y spotify-client
  
  curl --location --output discord.deb https://discord.com/api/download?platform=linux
  sudo apt install -y ./discord.deb
  rm discord.deb
  
  curl --location --remote-name https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb
  sudo apt install -y ./steam.deb
  rm steam.deb
  
  sudo apt install -y obs-studio
  
  # game mode
  sudo apt install -y meson libsystemd-dev pkg-config ninja-build git libdbus-1-dev libinih-dev
  git clone https://github.com/FeralInteractive/gamemode.git
  cd gamemode
  git checkout 1.7 # omit to build the master branch
  ./bootstrap.sh
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

# authenticate to GitHub
gh auth login --web

printf "\n\nDotfiles installed!\n\n"

# show system information once finished
neofetch
