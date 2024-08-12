# dotfiles 🌸

[![screenshot of rice](rice.png)](https://wallhaven.cc/w/gpmv73)
```
wm: dwm
launcher: dmenu
terminal: st
shell: zsh
editor: neovim
font: luxi mono
notifications: dunst
```

### ✨ about ✨
my dotfiles for gentoo, managed using git and make. the main focus of
this rice is to create a minimalistic linux system. eye candy is desired,
however, minimalism and performance come first. a majority of the tools i
use with this rice follow the suckless software design philsophy. i believe
that is a way of writing software that more people should adapt to.

### 💿 install
```sh
git clone https://git.sr.ht/~unrealapex/dotfiles ~/dotfiles
cd ~/dotfiles
make
```

### 🗒️ notes
this rice isn't intended for use by others, however, you're welcome to if
you wish. the information below might be of use to you.

my builds of dwm, dmenu, slock, etc... are stored in separate git repositories.
make is configured to build them.

dotfiles directories
```
$ tree -d -L 1
.
├── bin          ~/.local/bin/
├── config       ~/.config/
├── gnupg        ~/.gnupg/
├── gtk          gtk theme
├── scripts      config scripts
└── secrets      files containing secrets
```

**extras**

additional scripts in [scripts/](/scripts).
```
$ tree scripts
  scripts
    ├── emoji_gen          generate emojis file for emoji picker
    ├── firefox            generate firefox user.js file
    ├── irssi              set up irssi scripts
    └── kill-x             bind ctrl + alt + backspace to kill x
```

window decorations aren't functional since window management is done through
the keyboard, therefore, it's more logical to disable them. this can be done in
most gui apps by enabling the "use system titlebars" option.

secrets files for programs that have secrets(irssi, git) are in `secrets`.

🌈 color palette
```json
{
  "bg_color": "#0d0d0d",
  "bg_alt_color": "#262626",
  "fg_color": "#d9d0d0",
  "disabled_color": "#777777",
  "main_color": "#bf2a45"
}
```
