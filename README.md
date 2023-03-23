# dotfiles

<!-- todo: insert image of rice here -->
```
asciinema      > terminal recording
bat            > a cat(1) clone with wings
delta          > better git syntax highlighting
fzf            > fuzzy finder 
gh             > github cli
glow           > markdown parser
htop           > process viewer
hyperfine      > performance testing
lua            > lua language
lynx           > text based browser
neofetch       > show system information
neovim         > text editor
node           > nodejs
openjdk        > java language
ripgrep        > better grep
shellcheck     > shell script linter
stow           > symlink farm manager
tmux           > terminal multiplexer
```

### ✨ About ✨
Like most dotfiles, the files in this repository include the configurations that make my system fit my needs.

You're free to clone my config but it is generally [frowned upon](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked) because dotfiles tend be something really personal. Rather, if you are interested in using my config, I suggest copying whatever you like and putting it in your own config.
That being said, suggestions are definitely open! This config will only work on Debian based systems. It will not run without Curl and a stable internet connection. Additional dependencies are installed if not found.


### 👨‍💻 Usage
My dotfiles are managed using Git and GNU Stow. I use Git to manage version history and Stow to symlink everything to the directories my dotfiles need to be in. I prefer to manage my packages using Homebrew because certain packages in the APT repositories are outdated. This GitHub repository has multiple branches, each for a separate *Nix system. Each branches README has the appropriate one liner to install that branch's config. This branch is for Linux and Windows Subsystem for Linux.

### 📂 File Structure
<!-- tree -a -I .git -->
```
.
├── install.sh
├── misc
│   ├── .bashrc
│   ├── Brewfile
│   ├── .gitconfig
│   ├── .tmux.conf
│   └── .vimrc
├── nvim
│   └── .config
│       └── nvim
│           ├── after
│           │   └── ftplugin
│           │       └── java.lua
│           ├── .gitignore
│           ├── init.lua
│           ├── lua
│           │   ├── core
│           │   │   ├── autocmds.lua
│           │   │   ├── keymaps.lua
│           │   │   ├── lazy.lua
│           │   │   ├── options.lua
│           │   │   └── plugins.lua
│           │   └── plugins
│           │       ├── alpha.lua
│           │       ├── cmp.lua
│           │       ├── gitsigns.lua
│           │       ├── lsp.lua
│           │       ├── lualine.lua
│           │       ├── telescope.lua
│           │       └── treesitter.lua
│           └── .luarc.json
└── README.md

9 directories, 23 files
```

### 💿 Install
My dotfiles can be installed with this one liner:

```sh
source <(curl -s https://raw.githubusercontent.com/UnrealApex/dotfiles/master/install.sh)
```
You could also run the install script manually:
```sh
git clone https://github.com/UnrealApex/dotfiles ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
source install.sh
```
