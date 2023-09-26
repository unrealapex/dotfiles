#!/bin/bash

systemctl enable ly.service
systemctl enable mpd.service
systemctl --user disable pulseaudio.socket pulseaudio.service
systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service
systemctl enable tlp.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
systemctl enable bluetooth.service
systemctl enable --now irqbalance.service
systemctl enable cups.socket
systemctl enable libvirtd

