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

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

xset b off
xset +dpms
xset s 300 5
xss-lock --transfer-sleep-lock -- slock &

eval "$(dbus-launch --sh-syntax --exit-with-session)"

gentoo-pipewire-launcher &

playerctld daemon

xcompmgr &

unclutter --fork

while true; do
  xsetroot -name "$(date +"%m/%d %I:%M %P")"
  sleep 1
done &

if [ $(xrandr --query | grep --count "HDMI-1 connected") -eq 1 ]; then
  xrandr --output HDMI-1 --auto
  xrandr --output eDP-1 --off
else
  xrandr --output eDP-1 --auto
fi

feh --bg-fill "$WALLPAPER"

while true; do
  # Log stderror to a file
  dwm 2>/tmp/dwm.log
done
