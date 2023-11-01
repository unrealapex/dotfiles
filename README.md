# dotfiles 🌸

![screenshot of arch linux rice](rice.png)
```
wm: berry
bar: polybar
launcher: rofi
terminal: kitty
shell: zsh
editor: neovim
font: san francisco
notification daemon: dunst
colorscheme: charm
```

### ✨ about ✨
my dotfiles for arch linux, managed using git and dotbot.

### 💿 install
```sh
git clone https://github.com/unrealapex/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install
```

### 🗒️ notes
this rice is not intended for use by others, however, you're welcome to if
you wish. the information below might be of use to you.

the install script runs scripts (for arch) defined in [scripts/](/scripts).
```
$ tree scripts
  scripts
    ├── bluetooth.sh       enable bluetooth
    ├── group.sh           add current user to appropriate groups
    ├── kill-x.sh          bind ctrl + alt + backspace to kill x server
    ├── microcode.sh       generate grub config for cpu microcode
    ├── no-mouse-accel.sh  disable mouse acceleration
    ├── pacman.sh          install rice dependencies
    ├── services.sh        set up services for rice and dependencies
    └── zsh-rehash.sh      enable zsh rehash

```
you probably want to comment out every script that will
run in the `shell:` section of `install.conf.yaml` except for
`scripts/pacman.sh`.

git credentials(name and email) should be stored in `~/.gitconfig_local`. this
file is read by `~/.gitconfig`.

window decorations are not functional since window management with berry is
done through the keyboard, therefore, it is more functional and aesthetic to
disable them. this can be done in most gui apps by enabling the "use system
titlebars" option.

