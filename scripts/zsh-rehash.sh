#!/bin/bash

# on-demand rehash for new executables
sudo mkdir --parents /etc/pacman.d/hooks/ /var/cache/zsh
# create hook file
echo "[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Path
Target = usr/bin/*
[Action]
Depends = zsh
When = PostTransaction
Exec = /usr/bin/install -Dm644 /dev/null /var/cache/zsh/pacman" | sudo tee /etc/pacman.d/hooks/zsh.hook
