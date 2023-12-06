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
[[ $- != *i* ]] && return

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=2000
setopt auto_cd
setopt auto_pushd
setopt nocorrectall
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
bindkey "^X^E" edit-command-line

autoload -Uz compinit promptinit
compinit
promptinit

autoload edit-command-line
zle -N edit-command-line


add-zsh-hook -Uz precmd rehash_precmd

zstyle ':completion:*' menu select
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '_*'
# complete sudo commands
zstyle ':completion::complete:*' gain-privileges 1
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

function git_branch_name()
{
  branch=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  if [[ $branch == "" ]];
  then
    :
  else
    # FIXME: see if you can handle prompt spacing more elegantly
    # see Microsoft's implmention of the prompt they have in GitHub Codespaces
    echo ' %F{cyan}(%f%F{red}'$branch'%f%F{cyan})%f'
  fi
}

# enable substitution in the prompt
setopt prompt_subst

PROMPT='%F{green}@%n%f ➜ %F{blue}%B%~%b%f$(git_branch_name) $ '

# show a prompt without unicode symbols if in a tty
if [ x$DISPLAY = x ] ; then
  PROMPT='%F{green}@%n%f -> %F{blue}%B%~%b%f$(git_branch_name) $ '
fi

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
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

alias open='xdg-open > /dev/null 2>&1'
alias pls='sudo $(history -p !!)'
alias uwu='echo uwu'
alias icat='kitty +kitten icat'
alias connect="kitty +kitten ssh"
alias theme="kitty +kitten themes --reload-in=all"
# TODO: use a better method to manage clipboard, clipboard kitten is lacking
alias clip='kitty +kitten clipboard'
alias paste='kitty +kitten clipboard --get-clipboard'
# clean up orphaned packages
alias cleanpackages='yay -Rsn $(yay -Qdtq)'
alias freeram='echo 3 | sudo tee /proc/sys/vm/drop_caches'
# chill study music with lofi girl
alias studymusic="mpv 'https://www.youtube.com/watch?v=jfKfPfyJRdk' > /dev/null 2>&1 &;disown"
alias irssi="irssi --config=<((cat ~/.irssi/credentials && cat ~/.irssi/config))"

alias f='fff'

# bashbunni is awesome :D

declare -A pomo_options
pomo_options["work"]="60"
pomo_options["break"]="20"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  spd-say "'$val' session done"
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"


# upload a file to 0x0.st
upload () {
  if [[ $# == 1 ]] ; then
    curl -F"file=@$1" https://0x0.st
  elif [[ $# -gt 1 ]]; then
    echo "Multiple files given, confirm upload of each one"
    for file in "$@"; do
      echo -n "Are you sure you want to upload $file to 0x0.st? [Y/n]: "
      read confirm
      if [[ $confirm == [yY] || $confirm == [yY][eE][sS] || $confirm == "" ]]; then
        curl -F"file=@$file" https://0x0.st
      else
        echo "Not uploading $file"
      fi
    done
  else
    echo "Invalid file arguments provided
    Usage: upload [FILE]...
    " >&2
    exit 1 
  fi
}

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

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g CA="2>&1 | cat -A"
alias -g C='| wc -l'
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g ED="export DISPLAY=:0.0"
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
alias -g F=' | fmt -'
alias -g G='| egrep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g LL="2>&1 | less"
alias -g L="| less"
alias -g LS='| less -S'
alias -g MM='| most'
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g R=' > /c/aaa/tee.txt '
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g TL='| tail -20'
alias -g T='| tail'
alias -g US='| sort -u'
alias -g VM=/var/log/messages
alias -g X0G='| xargs -0 egrep'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep'
alias -g X='| xargs'
