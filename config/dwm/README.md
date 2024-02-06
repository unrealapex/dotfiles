# Aaron's build of dwm

### Patches
- [gaps](https://dwm.suckless.org/patches/gaps/)
- [switchtotag](https://dwm.suckless.org/patches/switchtotag/)

### Install
```bash
git clone https://github.com/unrealapex/dwm
cd dwm
sudo make clean install
```

### Setup
`~/.xinitrc`:
```bash
feh --bg-fill <aesthetic-wallpaper>

while true; do
   xsetroot -name "$( date +"%m/%d %I:%M %P" )"
   sleep 1
done &

while true; do
    # Log stderror to a file 
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
```

