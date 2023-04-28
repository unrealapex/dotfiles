#!/bin/bash
desktop=/tmp/lockscreen.png
# take a screenshot of the desktop
import -window root $desktop
# blur image and lock computer with blurred image as lockscreen background
convert $desktop -blur 0x8 $desktop && i3lock -i $desktop || i3lock
