#
# ~/.zprofile
#


[[ -f $ZDOTDIR/.zshrc ]] && . $ZDOTDIR/.zshrc

# FIXME: xdg compliance
eval "$(keychain --eval --ignore-missing --nogui --agents ssh,gpg --dir "$XDG_RUNTIME_DIR" --absolute)"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
