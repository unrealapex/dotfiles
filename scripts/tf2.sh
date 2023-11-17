#!/bin/bash

ln -s /usr/lib32/libSDL2-2.0.so.0 "$HOME/.steam/root/ubuntu12_32/steam-runtime/pinned_libs_32/"
rm "$HOME/.local/share/Steam/steamapps/common/Team Fortress 2/bin/libSDL2-2.0.so.0"
rm "$HOME/.local/share/Steam/steamapps/common/Team\ Fortress\ 2/bin/libtcmalloc_minimal.so.4"
