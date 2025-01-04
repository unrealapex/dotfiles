#
# ~/.config/zsh/zshrc
#


# bootstrap antidote
antidote="$XDG_DATA_HOME/antidote"
[ -d "$antidote" ] || git clone --depth=1 https://github.com/mattmc3/antidote.git "$antidote"


# source antidote
source "$antidote"/antidote.zsh

# initialize plugins statically with ~/.zsh_plugins.txt
antidote load


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=1000
SAVEHIST=2000
setopt auto_pushd
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt interactive_comments
setopt menu_complete
setopt nocorrectall
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

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Completion files: Use XDG dirs
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh

autoload -Uz compinit promptinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
promptinit

autoload edit-command-line
zle -N edit-command-line


zstyle ':completion:*' menu select
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '_*'
# complete sudo commands
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
# show hidden files in completion menu
_comp_options+=(globdots)

# disable highlighting of pasted text
zle_highlight+=(paste:none)

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

PROMPT='%n@%m:%1~ $ '

typeset -U path PATH
path+=(~/.local/bin ~/.local/share/cargo/bin ~/.local/share/nvim/mason/bin)
export PATH

# avoid removing/overwriting existing files by accident
cp() if [ -t 0 ]; then cp -iv "$@"; else cp "$@"; fi
mv() if [ -t 0 ]; then mv -iv "$@"; else mv "$@"; fi
rm() if [ -t 0 ]; then rm -iv "$@"; else rm "$@"; fi


# enable color support of ls and also add handy aliases
if [ "$(tput colors 2>/dev/null || echo 0)" -ge 8 ]; then
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias tree='tree -C'
fi


# some more ls aliases
alias ll='ls -Ahl1'
alias la='ls -A'
alias l='ls -C'
alias j='jobs -l'
alias h='fc -l'
alias sudo='doas'
alias pls='sudo $(history -p !!)'
alias uwu='echo uwu'
alias bc='bc --mathlib --quiet'
alias pidgin='pidgin --config="$XDG_DATA_HOME"/purple'
alias mbsync='mbsync -c "$XDG_CONFIG_HOME"/isync/mbsyncrc'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias dosbox='dosbox -conf "$XDG_CONFIG_HOME"/dosbox/dosbox.conf'
alias abook='abook --config "$XDG_CONFIG_HOME"/abook/abookrc --datafile "$XDG_DATA_HOME"/abook/addressbook'
alias ytflac='yt-dlp -x --audio-format flac --audio-quality 10'
alias sxiv="nsxiv"
alias mutt="neomutt"
alias vkquake='gamemoderun vkquake -basedir ~/.local/share/Steam/steamapps/common/Quake'
alias bat="cat /sys/class/power_supply/BAT0/{capacity,status}"
alias weather="curl wttr.in"
alias d='dirs -v'
# handle programs that incorrectly read EDITOR instead of VISUAL
alias neomutt="EDITOR=$VISUAL neomutt"

diff() {
  if [ -t 0 ]; then
    if command -v diff-so-fancy >/dev/null; then
      diff -u "$@" | diff-so-fancy
    else
      diff -u "$@" | sed 's/^-/\x1b[31m-/;s/^+/\x1b[32m+/;s/^@/\x1b[1;34m@/;s/$/\x1b[0m/'
    fi
  else
    diff -u "$@"
  fi
}

# wrapper for xdg-open to open multiple uris
o() {
  if [ "$#" -eq 0 ]; then
    echo "Usage: o [file|directory|protocol]"
    return 1
  fi

  for uri in "$@"; do
    xdg-open "$uri"
  done
}


alias f='fff'
alias cleanpatches='find -type f \( -name "*.orig" -o -name "*.rej" \) -delete'
alias -- -='cd -'
alias glow='pandoc -f commonmark_x $@ -t ansi'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

c() {
  dir=$(fd -H -t d | fzy)
  [ -d "$dir" ] && cd "$dir"
}

t() {
  fd -H -t f -t d | fzy
}

ff() {
  files=$(fd -H | fzy)
  [ -n "$files" ] && "$VISUAL" "$files"
}

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# vim: filetype=sh
