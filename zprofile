#
# ~/.zprofile
#


[[ -f ~/.zshrc ]] && . ~/.zshrc

eval "$(keychain --eval --ignore-missing --nogui --agents ssh,gpg)"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
