# 🌺 dotfiles

[![screenshot of rice](rice.png)](https://wallhaven.cc/w/gpmv73)
```
wm: dwm
launcher: dmenu
terminal: st
shell: yash
editor: vim
notifications: dunst
```

### ✨ about ✨
these are my dotfiles. version control is done with git. make is used to symlin
k everything and compile my builds of suckless programs. i strive to use tools
which align well with the unix philosophy.

### 💿 install
```sh
git clone https://git.sr.ht/~unrealapex/dotfiles ~/dotfiles
cd ~/dotfiles
make
```

### 🗒️ extras
window decorations should be turned off for gui apps that have the option. this
can be done in most apps by enabling the "use system titlebars" option.

skeleton files for programs that have secrets(git) are in `secrets`.

🌈 x11 color palette
```css
* {
  --bg-color: "darkgray";
  --fg-color: "white";
  --main-color: "maroon";
}
```
