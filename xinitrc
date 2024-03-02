#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

# change default cursor to a pointer
xsetroot -cursor_name left_ptr
# xrdb "$HOME"/.Xresources


xss-lock --transfer-sleep-lock -- "betterlockscreen --lock" --nofork &
xautolock -time 10 -locker "idle-lock" &

feh --bg-fill "$WALLPAPER"
picom --daemon

playerctld daemon

# killall lemonbar
# bash lemon | lemonbar &
# xdo above -t $(xdo id -n root) $(xdo id -n lemonbar)

# TODO: find something less bloated than ibus
# ibus-daemon --replace --xim --daemonize

keepassxc &

tiramisu-daemon &

unclutter &

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
