#
# ~/.zprofile
#


[[ -f ~/.zshrc ]] && . ~/.zshrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

eval "$(ssh-agent -s)"
