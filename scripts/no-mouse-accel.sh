#!/bin/bash
# disable mouse acceleration
echo 'Section "InputClass"
  Identifier "My Mouse"
  Driver "libinput"
  MatchIsPointer "yes"
  Option "AccelProfile" "flat"
  Option "AccelSpeed" "0"
EndSection' | sudo tee /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
