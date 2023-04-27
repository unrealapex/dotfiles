#!/bin/bash
desktop=/tmp/lockscreen.png
# take a screenshot of the desktop
import -window root $desktop
# blur image
convert $desktop -blur 0x8 $desktop
# lock computer and set blurred image as lockscreen background
i3lock -i $desktop
