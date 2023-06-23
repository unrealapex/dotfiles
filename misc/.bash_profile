#
# ~/.bash_profile
#


# default programs
export EDITOR=/usr/bin/nvim
export TERMINAL="kitty"
export TERMINAL_PROG="kitty"
# TODO: check if the executable is google-chrome or google-chrome-stable
export BROWSER=/usr/bin/google-chrome

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart X at login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
