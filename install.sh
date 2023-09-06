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

[ -d ~/.dotfiles ] || git clone https://gitlab.com/unrealapex/dotfiles.git ~/.dotfiles
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
# enable parallel downloads
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 20/g' /etc/pacman.conf
# enable colorful pacman output
sudo sed -i '/# Color/s/^#//g' /etc/pacman.conf
sudo pacman -Syu --noconfirm

# install packages
yay -S --noconfirm --needed - < packages

# Detect CPU vendor and model
vendor=$(grep vendor_id /proc/cpuinfo | awk '{print $3}' | head -n 1)
model=$(grep "model name" /proc/cpuinfo | awk -F": " '{print $2}' | head -n 1)

# install microcode
# Check if the CPU is Intel or AMD
if [[ $vendor == "GenuineIntel" ]]; then
   echo "Detected CPU: Intel $model"
   
   # Install the Intel microcode package
   sudo pacman -Syu --noconfirm --needed intel-ucode
   
   # Activate the microcode update
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   
elif [[ $vendor == "AuthenticAMD" ]]; then
   echo "Detected CPU: AMD $model"
   
   # Install the AMD microcode package
   sudo pacman -Syu --noconfirm --needed amd-ucode
   
   # Activate the microcode update
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   
else
   echo "Unsupported CPU: $vendor $model"
fi

echo "Microcode package installed and activated successfully!"


sudo grub-mkconfig -o /boot/grub/grub.cfg
backup_paths=(
  ~/.config/betterlockscreen
  ~/.config/bspwm
  ~/.config/dunst
  ~/.config/flameshot
  ~/.config/fontconfig/conf.d/01-emoji.conf
  ~/.config/gtk-3.0
  ~/.config/kitty
  ~/.config/lf
  ~/.config/neofetch
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
  ~/.icons
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

# disable mouse acceleration
echo 'Section "InputClass"
  Identifier "My Mouse"
  Driver "libinput"
  MatchIsPointer "yes"
  Option "AccelProfile" "flat"
  Option "AccelSpeed" "0"
EndSection' | sudo tee /etc/X11/xorg.conf.d/50-mouse-acceleration.conf

# TODO: do this after initial install
modprobe btusb

# make sure bluetooth stuff start up after a restart
sudo sed -i "s/AutoEnable=false/AutoEnable=true/" /etc/bluetooth/main.conf

# install neovim plugins
# TODO: check if Mason language servers get installed too
nvim --headless "+Lazy! sync" +qa

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


# set custom icon for kitty
sed -e 's|Icon=.*|Icon=~/.dotfiles/kitty/.config/kitty/kitty.png|' /usr/share/applications/kitty.desktop > ~/.local/share/applications/kitty.desktop

# cache lockscreen image
# FIXME: this has to be perfomred after initial setup
# betterlockscreen --update ~/.dotfiles/sakura.png

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
systemctl enable mpd.service
systemctl --user disable pulseaudio.socket pulseaudio.service
systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service
systemctl enable tlp.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
systemctl enable bluetooth.service
systemctl enable --now irqbalance.service
systemctl enable betterlockscreen@$USER

gpasswd -a $USER plugdev

cd

printf "\n\nDotfiles installed!\n\n"

# show system information once finished installing
neofetch
