#
# ~/.zshrc
#


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=2000
setopt nonomatch
setopt correctall
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt extended_glob

bindkey -e
bindkey '^[[Z' reverse-menu-complete

autoload -Uz compinit promptinit
compinit
promptinit


add-zsh-hook -Uz precmd rehash_precmd

zstyle ':completion:*' menu select
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
# show hidden files in completion menu
_comp_options+=(globdots)

# disable highlighting of pasted text
zle_highlight+=(paste:none)


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

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

PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '

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
alias ll='exa -alF'
alias la='exa -a'
alias l='exa'

alias open='xdg-open'
alias pls='sudo $(history -p !!)'
alias uwu='echo uwu'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
