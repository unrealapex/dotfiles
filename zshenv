#
# ~/.zshenv
#


export EDITOR="nvim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export BROWSER="firefox"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export MANPAGER="sh -c 'col --no-backspaces --spaces | bat --language man --style=plain'"
export MANROFFOPT="-c"
export LESS="--ignore-case"
export FZF_DEFAULT_OPTS='--no-unicode --color=bg+:-1,bg:-1'
# NOTE: some quotation issue with --place is causing image preview to fail :/
export FZF_CTRL_T_OPTS="
  --preview 'fzf-preview {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FFF_FAV1=~/Downloads
export FFF_FAV2=~/Documents
export FFF_FAV3=~/music
export FFF_FAV4=~/Pictures
export FFF_FAV5=~/Videos
export FFF_FAV6=~/.dotfiles
export FFF_FAV7=~/projects
export FFF_FAV8=~/.zshrc
export FFF_FAV9=~/.xinitrc
export WALLPAPER="$HOME/.dotfiles/sakura.png"
# export MANGOHUD=1

# set ibus as input method framework
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export GLFW_IM_MODULE=ibus

export W3M_DIR="$XDG_CONFIG_HOME/w3m" 
export WWW_HOME='https://lite.duckduckgo.com/lite'

export PATH
