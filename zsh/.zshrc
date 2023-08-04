#
# ~/.zshrc
#

# bootstrap antidote
[ -d ~/.antidote ] || git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote


# source antidote
source ~/.antidote/antidote.zsh

# initialize plugins statically with ~/.zsh_plugins.txt
antidote load


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=2000
setopt auto_cd
setopt auto_pushd
setopt correctall
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt nonomatch
setopt pushd_ignore_dups
setopt pushdminus

bindkey -e
bindkey '^[[Z' reverse-menu-complete
# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word
# [Ctrl-Backspace] - delete whole forward-word
bindkey '^H' backward-kill-word
# history substring search bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
autoload -Uz compinit promptinit
compinit
promptinit


add-zsh-hook -Uz precmd rehash_precmd

zstyle ':completion:*' menu select
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# show hidden files in completion menu
_comp_options+=(globdots)

# disable highlighting of pasted text
zle_highlight+=(paste:none)


zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
    if [[ -a /var/cache/zsh/pacman ]]; then
        local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
        if (( zshcache_time < paccache_time )); then
            rehash
            zshcache_time="$paccache_time"
        fi
    fi
}

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f $ '

typeset -U path PATH
path=(~/.local/bin $path)
export PATH

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias open='xdg-open'
alias pls='sudo $(history -p !!)'
alias uwu='echo uwu'


alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'


function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
