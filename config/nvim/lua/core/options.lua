vim.opt.autoread = true
vim.opt.background = "dark"
vim.opt.backspace = "indent,eol,start"
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.directory = vim.fn.stdpath("state") .. "/swap"
-- disable annoying error bell
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.formatoptions = "jcroqlnt"
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.guicursor = ""
vim.opt.hidden = true
vim.opt.history = 500
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.magic = true
vim.opt.number = true
vim.opt.numberwidth = 8
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.path:append(".,**")
vim.opt.pumheight = 12
vim.opt.ruler = true
vim.opt.scrolloff = 8
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.signcolumn = "auto:1-2"
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.termguicolors = false
vim.opt.textwidth = 73
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undofile = true
vim.opt.undolevels = 500
vim.opt.updatetime = 200
vim.opt.visualbell = false
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false

vim.cmd.syntax("on")
vim.cmd.colorscheme("vim")
vim.cmd.highlight({ "clear", "SignColumn" })
vim.cmd.highlight({ "normal", "guibg=NONE" })

--globals

-- set the mapleader to space
vim.g.mapleader = " "

-- vim.g["rainbow#pairs"] = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

-- environment variables

-- $CONFIG
vim.env.CONFIG = vim.fn.stdpath("config")

-- $OPTIONS
vim.env.OPTIONS = vim.fn.stdpath("config") .. "/lua/core/options.lua"

-- $LAZY
vim.env.LAZY = vim.fn.stdpath("config") .. "/lua/core/lazy.lua"

-- $PLUGINS
vim.env.PLUGINS = vim.fn.stdpath("config") .. "/lua/plugins"

-- $KEYMAPS
vim.env.KEYMAPS = vim.fn.stdpath("config") .. "/lua/core/keymaps.lua"

-- $AUTOCMDS
vim.env.AUTOCMDS = vim.fn.stdpath("config") .. "/lua/core/autocmds.lua"

-- $LSP
vim.env.LSP = vim.fn.stdpath("config") .. "/lua/plugins/lsp.lua"

-- $FTPLUGIN
vim.env.FTPLUGIN = vim.fn.stdpath("config") .. "/after/ftplugin"
