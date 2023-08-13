# dotfiles

![screenshot of arch linux rice](rice.png)
```
wm: bspwm
bar: polybar
launcher: rofi
terminal: kitty
shell: zsh
editor: nvim
font: jetbrains mono
notification daemon: dunst
colorscheme: catppuccin mocha
```

### ✨ about ✨
my dotfiles for arch linux, managed using git and gnu stow.

### 💿 install
my dotfiles can be installed with this one liner:

```sh
source <(curl -s https://gitlab.com/unrealapex/dotfiles/-/raw/master/install.sh)
```
if you wish to try out my configuration without the specific os modifications the install script makes, it is possible to just stow desired configuration folders:

```sh
git clone https://gitlab.com/unrealapex/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow */
```
