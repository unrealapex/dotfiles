#!/bin/bash
desktop=/tmp/lockscreen.png
# take a screenshot of the desktop
import -window root $desktop
# pixelate image
convert -scale 10% -scale 1000% $desktop $desktop
# set image as lockscreen
i3lock -i $desktop
