# dotfiles

<!-- todo: insert image of rice here -->
```
os: arch
wm: bspwm
bar: polybar
launcher: rofi
terminal: kitty
shell: zsh
editor: nvim
font: jetbrains mono
notification daemon: dunst
colorscheme: tokyonight
```

### ✨ About ✨
My dotfiles for Arch Linux, managed using Git and GNU Stow.

### 💿 Install
My dotfiles can be installed with this one liner:

```sh
source <(curl -s https://gitlab.com/unrealapex/dotfiles/-/raw/master/install.sh)
```

It is also possible to manually try my configuration:

```sh
git clone https://gitlab.com/unrealapex/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow */
```