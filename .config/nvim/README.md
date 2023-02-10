# .dotfiles
### About
This repo just contains my Neovim configuration for now. Like most dotfiles, the files in this repository include the configurations that make my system fit my needs.

You're free to copy my config but it is generally [frowned upon](https://github.com/romainl/idiomatic-vimrc) because dotfiles tend be something really personal. Rather, if you are interested in using my config, I suggest copying whatever you like and putting it in your own config.
That being said, suggestions are definitely open!

### Plugins
I have several plugins to enhance my experience using Neovim. As a side note, this config only works in Neovim. If you use Vim, it might be more relevant to look at my [`.vimrc`](/.vimrc).
My plugins are managed using [lazy.nvim](https://github.com/folke/lazy.nvim). Lazy is [bootstrapped](https://github.com/UnrealApex/dotfiles/blob/main/lua/core/lazy.lua#L1-L13) automatically.
The plugins I use are [here](https://github.com/UnrealApex/dotfiles/blob/main/lua/core/plugins.lua).

**Notes**
This config has several dependencies. Plugins will break if these are not installed:

- [Neovim v0.8.0 or higher](https://github.com/neovim/neovim)
- [Git](https://git-scm.com/)
- [Nodejs](https://nodejs.org/en/)
- [LLVM](https://www.llvm.org/)
- [GNU Compiler Collection](https://gcc.gnu.org/)
- [make](https://www.gnu.org/software/make/)
- [python](https://www.python.org/)
- [pynvim](https://github.com/neovim/pynvim)
- [Ripgrep](https://github.com/BurntSushi/ripgrep)
- a [nerd font](https://github.com/ryanoasis/nerd-fonts)
- [Glow](https://github.com/charmbracelet/glow)

---
If you're interested in what I'm currently working on, I have a [GitHub project](https://github.com/users/UnrealApex/projects/2) that I use to track my Neovim journey.
