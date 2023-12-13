# dotfiles 🌸

![screenshot of rice](rice.png)
```
wm: bspwm
bar: polybar
launcher: rofi
terminal: kitty
shell: zsh
editor: neovim
font: san francisco
notification daemon: dunst
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

the install script runs scripts (for arch) listed in [scripts/](/scripts).
```
$ tree scripts
  scripts
    ├── bluetooth          enable bluetooth
    ├── firefox            generate firefox user.js file
    ├── group              add current user to appropriate groups
    ├── irssi              set up irssi scripts
    ├── kill-x             bind ctrl + alt + backspace to kill x
    ├── laptop             useful laptop stuff
    ├── microcode          install microcode updates
    ├── no-mouse-accel     disable mouse acceleration
    ├── pacman             optimize pacman and install rice packages
    ├── proton-ge          install glorious eggroll's custom proton build
    ├── services           set up services for rice and dependencies
    ├── tf2                fix common issues running tf2 on linux
    ├── ufw                enable uncomplicated firewall
    └── zsh-rehash         enable zsh rehash

```
you probably want to comment out every script that will
run in the `shell:` section of `install.conf.yaml` except for
`scripts/pacman`.

your git credentials(name and email) should be added in `~/.gitconfig_local`. this
file is read by `~/.gitconfig`.

window decorations are not functional since window management is primarily
done through the keyboard, therefore, it is more logical to
disable them. this can be done in most gui apps by enabling the "use system
titlebars" option.

irssi credentials should be added in `~/.irssi/credentials`.
