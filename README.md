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
feh            > image viewer, wallpaper setting
ffmpeg         > video manipulation
fzf            > fuzzy finder 
gh             > github cli
gamemode       > optimize gaming performance
glow           > markdown parser
htop           > process viewer
hyperfine      > performance testing
i3             > window manager
imagemagick    > image related operations
lua            > lua language
lynx           > text based browser
neofetch       > show system information
neovim         > text editor
node           > nodejs
notify-send    > send desktop notifications
obs-studio     > screencast recorder
ripgrep        > better grep
rofi           > application launcher
shellcheck     > shell script linter
spotify        > music player
steam          > games library
stow           > symlink farm manager
tmux           > terminal multiplexer
wget           > get resources from the internet
```

### ✨ About ✨
Like most dotfiles, the files in this repository include the configurations that make my system fit my needs.

You're free to clone my config but it is generally [frowned upon](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked) because dotfiles tend be something really personal. Rather, if you are interested in using my config, I suggest copying whatever you like and putting it in your own config.
That being said, suggestions are definitely open! This config will only work on Debian based distributions. The install script requires that you have `curl` installed. You can install it with `sudo apt install curl`.


### 👨‍💻 Usage
My dotfiles are managed using Git and GNU Stow. I use Git to manage version history and Stow to symlink the folders in this repository to their locations on system. Most of my packages are installed using Apt, but I also use Homebrew for certain packages not availible in the Debian package repositories, are easier to install via Homebrew, or if I need the latest version of said package.

### 💿 Install
My dotfiles can be installed with this one liner:

```sh
source <(curl -s https://gitlab.com/UnrealApex/dotfiles/-/raw/master/install.sh)
```
