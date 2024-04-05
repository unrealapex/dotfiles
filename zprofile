#
# ~/.zprofile
#


[[ -f ~/.zshrc ]] && . ~/.zshrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

keys=$(find ~/.ssh -type f -name "id_*" -not -name "*.pub")
eval $(keychain --eval --agents ssh $keys)
