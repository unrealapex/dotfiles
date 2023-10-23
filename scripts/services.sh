#!/bin/bash

systemctl enable gdm.service
systemctl --user enable mpd.socket
systemctl --user disable pulseaudio.socket pulseaudio.service
systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service
systemctl enable tlp.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
systemctl enable bluetooth.service
systemctl enable --now irqbalance.service
systemctl enable cups.socket
systemctl enable libvirtd
systemctl enable betterlockscreen@$USER
