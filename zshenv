#
# ~/.zshenv
#


export EDITOR="nvim"
export TERMINAL="kitty"
export TERMINAL_PROG="kitty"
export BROWSER="firefox"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export LESS="-i"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#000000,bg:#000000,spinner:#bf4e6d,hl:#c6a4a8 \
--color=fg:#484f55,header:#e3d1d0,info:#e3d1d0,pointer:#e3e4e7  \
--color=marker:#ed567a,fg+:#e3e4e7,prompt:#bf4e6d,hl+:#c6a4a8"
# export MANGOHUD=1

# set ibus as input method framework
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export GLFW_IM_MODULE=ibus

export SDL_VIDEO_X11_DGAMOUSE=0
export UBUNTU_MENUPROXY=''

export PATH
