#
# ~/.zprofile
#


[[ -f ~/.zshrc ]] && . ~/.zshrc

# TODO: check if this works with keepass
eval "$(ssh-agent -s)"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
