#
# ~/.bash_profile
#


# default programs
export EDITOR="nvim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export BROWSER="firefox"
export HISTFILE="${XDG_STATE_HOME}"/bash/history

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart X at login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
