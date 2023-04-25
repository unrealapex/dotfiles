# dotfiles

<!-- todo: insert image of rice here -->
```
anaconda       > python distribution
asciinema      > terminal recording
bat            > a cat(1) clone with wings
default-jdk    > java development kit
default-jre    > java runtime environment
delta          > better git syntax highlighting
discord        > instant messaging 
dunst          > notification daemon
feh            > image viewer, wallpaper setting
ffmpeg         > video manipulation
flameshot      > screenshot tool
fzf            > fuzzy finder 
gamemode       > gaming optimizations 
gimp           > image manipulation software
glow           > markdown parser
htop           > process viewer
hyperfine      > performance testing
i3             > tiling window manager
imagemagick    > software suite for images
kdenlive       > video editor
krita          > raster graphics editor
libnotify    > send desktop notifications
libreoffice    > office software suite
lightdm        > display manager
lua            > lua language
lynx           > text based browser
neofetch       > show system information
neovim         > text editor
node           > nodejs
obs-studio     > screencast recorder
picom          > compositor
ripgrep        > better grep
rofi           > application launcher
shellcheck     > shell script linter
spotify        > music player
steam          > games library
stow           > symlink farm manager
tor            > spooky dark web things
tmux           > terminal multiplexer
wine           > windows compatibility layer
wget           > get resources from the internet
```

### ✨ About ✨
Like most dotfiles, the files in this repository include the configurations that make my system fit my needs.

You're free to clone my config but it is generally [frowned upon](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked) because dotfiles tend be something really personal. Rather, if you are interested in using my config, I suggest copying whatever you like and putting it in your own config.
That being said, suggestions are definitely open! This config will only work on Arch based distributions.


### 👨‍💻 Usage
My dotfiles are managed using Git and GNU Stow. I use Git to manage version history and Stow to symlink the folders in this repository to their locations on system. Most of my packages are installed using Pacman.

### 💿 Install
My dotfiles can be installed with this one liner:

```sh
pacman -S curl git && source <(curl -s https://gitlab.com/unrealapex/dotfiles/-/raw/arch/install.sh)
```
