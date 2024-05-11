#
# ~/.zprofile
#


[[ -f ~/.zshrc ]] && . ~/.zshrc

# TODO: check if this works with keepass
eval "$(keychain --eval --ignore-missing --nogui)"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
