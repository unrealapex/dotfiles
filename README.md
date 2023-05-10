# dotfiles

<!-- todo: insert image of rice here -->
```
anaconda       > python distribution
asciinema      > terminal recording
bash-completion> better completion
bat            > a cat(1) clone with wings
delta          > better git syntax highlighting
discord        > instant messaging 
dunst          > notification daemon
exa            > a modern replacement for ls
feh            > image viewer, wallpaper setting
firefox        > browser
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
lf             > file manager
libnotify      > send desktop notifications
libreoffice    > office software suite
lua            > lua language
lynx           > text based browser
neofetch       > fetch system information
neovim         > text editor
node           > nodejs
npt            > time syncrhonization
obs-studio     > screencast recorder
picom          > compositor
qalculate      > calculator
ripgrep        > better grep
shellcheck     > shell script linter
spotify        > music player
steam          > games library
stow           > symlink farm manager
tor            > spooky dark web things
tmux           > terminal multiplexer
wine           > windows compatibility layer
wget           > get resources from the internet
xorg           > x window system display server
```

### ✨ About ✨
Like most dotfiles, the files in this repository include the configurations that make my system fit my needs.

You're free to clone my config but it is generally [frowned upon](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked) because dotfiles tend be something really personal. Rather, if you are interested in using my config, I suggest copying whatever you like and putting it in your own config.
That being said, suggestions are definitely open! This config will only work on Arch based distributions.


### 👨‍💻 Usage
My dotfiles are managed using Git and GNU Stow. I use Git to manage version history and Stow to symlink the folders in this repository to their locations on system. My packages are installed using Pacman.

### 💿 Install
My dotfiles can be installed with this one liner:

```sh
sudo pacman -S curl git && source <(curl -s https://gitlab.com/unrealapex/dotfiles/-/raw/master/install.sh)
```
**Make sure you do not run this as root.**

