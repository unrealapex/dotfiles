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

git clone https://gitlab.com/unrealapex/dotfiles.git ~/.dotfiles
cd ~/.dotfiles || exit 1

# yay
mkdir --parents ~/Downloads/git
cd ~/Downloads/git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
yes | makepkg -si

cd ~/.dotfiles

# enable multilib
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

# install packages
yay -S --noconfirm --needed - < packages


backup_paths=(
  ~/.config/betterlockscreen
  ~/.config/bspwm
  ~/.config/dunst
  ~/.config/flameshot
  ~/.config/fontconfig/conf.d/01-emoji.conf
  ~/.config/kitty
  ~/.config/lf
  ~/.config/nvim
  ~/.config/picom
  ~/.config/pipewire
  ~/.config/polybar
  ~/.config/zsh
  ~/.bash_history
  ~/.bash_logout
  ~/.bash_profile
  ~/.bashrc
  ~/.gitconfig
  ~/.gitconfig_local
  ~/.tmux.conf
  ~/.vimrc
  ~/.xinitrc
  ~/.zprofile
  ~/.zsh_plugins.txt
  ~/.zshenv
  ~/.zshrc
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

# set default shell as zsh
chsh -s /bin/zsh

# on-demand rehash for new executables
sudo mkdir --parents /etc/pacman.d/hooks/ /var/cache/zsh
# create hook file
echo "[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Path
Target = usr/bin/*
[Action]
Depends = zsh
When = PostTransaction
Exec = /usr/bin/install -Dm644 /dev/null /var/cache/zsh/pacman" | sudo tee /etc/pacman.d/hooks/zsh.hook

# TODO: do this after initial install
# modprobe btusb

# make sure bluetooth stuff start up after a restart
# sudo sed -i "s/AutoEnable=false/AutoEnable=true/" /etc/bluetooth/main.conf

# install neovim plugins
# TODO: check if Mason language servers get installed too
nvim --headless "+Lazy! sync" +qa

# install icon fonts
echo "Installing fonts..."
sudo mkdir --parents /usr/share/fonts/truetype/
cd /usr/share/fonts/truetype

# download nerd font
sudo curl --fail --location --output "JetBrains Mono Nerd Font Complete Regular.ttf" \
  https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf?raw=true

# FIXME: this doesn't work as intended
# download fontawesome font
# TODO: don't hardcode url to latest release  
sudo curl --fail --location --output fontawesome.zip https://use.fontawesome.com/releases/v6.4.0/fontawesome-free-6.4.0-desktop.zip
unzip fontawesome.zip
cd fontawesome-*-desktop/otfs
sudo mkdir --parents /usr/share/fonts/fontawesome/
sudo cp * /usr/share/fonts/fontawesome/
rm fontawesome.zip

sudo fc-cache -fv

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
# NOTE: it's not a good idea to attempt to disable these services right after a fresh install
# (pulseaudio is not enabled yet)
systemctl --user disable --now pulseaudio.socket pulseaudio.service
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
sudo systemctl enable bluetooth.service


printf "\n\nDotfiles installed!\n\n"

# show system information once finished installing
neofetch
