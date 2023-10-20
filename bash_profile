#
# ~/.bash_profile
#


# default programs
export EDITOR=/usr/bin/nvim
export TERMINAL="kitty"
export TERMINAL_PROG="kitty"
export BROWSER=/usr/bin/brave

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart X at login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
