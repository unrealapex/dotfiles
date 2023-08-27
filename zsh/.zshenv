#
# ~/.zshenv
#


export EDITOR=/usr/bin/nvim
export TERMINAL="kitty"
export TERMINAL_PROG="kitty"
export BROWSER=/usr/bin/firefox

# set ibus as input method framework
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# TODO: add Anaconda to path
path=("/home/aaron/anaconda3/bin" $path)

export PATH
