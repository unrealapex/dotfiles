# dotfiles 🌸

[![screenshot of rice](rice.png)](https://wallhaven.cc/w/gpmv73)
```
wm: dwm
launcher: dmenu
terminal: st
shell: zsh
editor: neovim
font: liberation mono
notifications: dunst
```

### ✨ about ✨
my dotfiles for gentoo, managed using git and dotbot. the main focus of
this rice is to create a minimalistic linux system. eye candy is desired,
however, minimalism and performance come first. a majority of the tools that i
use with this rice follow the suckless software design philsophy. i believe
that is a way of writing software that more people should adapt to.

### 💿 install
```sh
git clone https://git.sr.ht/~unrealapex/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install
```

### 🗒️ notes
this rice is not intended for use by others, however, you're welcome to if
you wish. the information below might be of use to you.

my builds of dwm, dmenu, slock, etc.. are stored in separate git repositories.
dotbot is configured to build them.

dotfiles directories
```
$ tree -d -L 1
.
├── bin          ~/.local/bin/
├── config       ~/.config/
├── dotbot       dotbot binary
├── scripts      config scripts
├── secrets      files containing secrets
└── themes       gtk theme
```

dotbot runs these additional scripts in [scripts/](/scripts).
```
$ tree scripts
  scripts
    ├── bluetooth          enable bluetooth
    ├── emoji_gen          generate emojis file for emoji picker
    ├── firefox            generate firefox user.js file
    ├── group              add current user to appropriate groups
    ├── irssi              set up irssi scripts
    ├── kill-x             bind ctrl + alt + backspace to kill x
    ├── microcode          install microcode updates
    ├── no-mouse-accel     disable mouse acceleration
    ├── proton-ge          install glorious eggroll's custom proton build
    ├── secrets            create secrets
    ├── tf2                fix common issues running tf2 on linux
    └── ufw                enable uncomplicated firewall

```

**extras**

window decorations are not functional since window management is primarily
done through the keyboard, therefore, it is more logical to
disable them. this can be done in most gui apps by enabling the "use system
titlebars" option.

secrets files for programs that have secrets(irssi, git) are in `secrets`.

color palette
```json
{

  "bg_color": "#0d0d0d",
  "bg_alt_color": "#262626",
  "fg_color": "#d9d0d0",
  "disabled_color": "#777777",
  "main_color": "#bf2a45"
}
```
