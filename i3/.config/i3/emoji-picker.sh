#!/bin/sh
# luke smith is the best

# Get user selection via dmenu from emoji file.
chosen=$(cut -d ';' -f1 ~/.config/i3/emojis | dmenu -i -l 10 | sed "s/ .*//")
xdotool type "$chosen"


