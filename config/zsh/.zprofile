#
# ~/.config/zsh/zprofile
#


[ -f $ZDOTDIR/.zshrc ] && . $ZDOTDIR/.zshrc

eval "$(keychain --eval --ignore-missing --nogui --agents ssh,gpg --dir "$XDG_RUNTIME_DIR" --absolute)"

[ -t 0 ] && [ "$(tty)" = "/dev/tty1" ] && [ ! "$DISPLAY" ] && exec startx
