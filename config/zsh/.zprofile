#
# ~/.config/zsh/zprofile
#


[[ -f $ZDOTDIR/.zshrc ]] && . $ZDOTDIR/.zshrc

eval "$(keychain --eval --ignore-missing --nogui --agents ssh,gpg --dir "$XDG_RUNTIME_DIR" --absolute)" &

# portable way to check if we're on the first tty
# /dev/ttyv0 is openbsd's first tty, /dev/tty1 is linux's first tty
# FIXME: see if you can make tty detection universal
[ -t 0 ] && [ "$(tty)" = "/dev/ttyv0" ] || [ "$(tty)" = "/dev/tty1" ] && [ ! "$DISPLAY" ] && exec startx
