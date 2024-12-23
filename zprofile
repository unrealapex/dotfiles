#
# ~/.zprofile
#

export ZDOTDIR=$HOME/.config/zsh
export EDITOR="nvim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export BROWSER="firefox"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export LESS="--ignore-case --RAW-CONTROL-CHARS"
# make less more friendly for non-text input files, see lesspipe(1)
export LESSOPEN="|lesspipe %s"
export FZF_DEFAULT_OPTS='--no-unicode --color=bg+:-1,bg:-1'
export FZF_CTRL_T_OPTS="
  --preview 'cat {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FFF_FAV1=~/Downloads
export FFF_FAV2=~/Documents
export FFF_FAV3=~/Music
export FFF_FAV4=~/Pictures
export FFF_FAV5=~/Videos
export FFF_FAV6=~/dotfiles
export FFF_FAV7=~/projects
export FFF_FAV8=~/.zshrc
export FFF_FAV9=~/.xinitrc
export WALLPAPER="$HOME/dotfiles/sakura.png"
# export MANGOHUD=1

# set fcitx as input method framework
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export WWW_HOME='https://lite.duckduckgo.com/lite'
# st supports true color
export COLORTERM=truecolor

export PASSWORD_STORE_CLIP_TIME=15
export PASSWORD_STORE_GENERATED_LENGTH=50

# xdg compliance
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export BUNDLE_USER_CACHE=$XDG_CACHE_HOME/bundle
export BUNDLE_USER_CONFIG=$XDG_CONFIG_HOME/bundle/config
export BUNDLE_USER_PLUGIN=$XDG_DATA_HOME/bundle
# FIXME: prevent this from breaking ebuilds
# export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export WINEPREFIX="$XDG_DATA_HOME"/wine
export RANDFILE="$XDG_RUNTIME_DIR"/rnd
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export LYNX_CFG="$XDG_CONFIG_HOME"/lynx/lynx.cfg
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod



[ -f $ZDOTDIR/.zshrc ] && . $ZDOTDIR/.zshrc

eval "$(keychain --eval --ignore-missing --nogui --agents ssh,gpg --dir "$XDG_RUNTIME_DIR" --absolute)"

[ -t 0 ] && [ "$(tty)" = "/dev/tty1" ] && [ ! "$DISPLAY" ] && exec startx
