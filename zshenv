#
# ~/.zshenv
#


export EDITOR=/usr/bin/nvim
export TERMINAL="kitty"
export TERMINAL_PROG="kitty"
export BROWSER=/usr/bin/firefox
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export LESS="-i"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#171717,bg:#171717,spinner:#ee6ff8,hl:#ecfd65 \
--color=fg:#777777,header:#fffdf5,info:#7571f9,pointer:#dddddd  \
--color=marker:#ed567a,fg+:#dddddd,prompt:#ee6ff8,hl+:#ecfd65"
# export MANGOHUD=1

# set ibus as input method framework
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export GLFW_IM_MODULE=ibus

export SDL_VIDEO_X11_DGAMOUSE=0
export UBUNTU_MENUPROXY=''

export PATH
