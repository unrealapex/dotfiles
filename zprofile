#
# ~/.zprofile
#


[[ -f ~/.zshrc ]] && . ~/.zshrc

keys=$(find ~/.ssh -type f -name "id_*" -not -name "*.pub")
eval $(keychain --eval --agents ssh $keys)

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
