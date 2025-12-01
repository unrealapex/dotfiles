vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.complete:append("f")
vim.opt.expandtab = true
vim.opt.formatoptions:append("roln")
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.guicursor = ""
vim.opt.ignorecase = true
vim.opt.magic = true
vim.opt.number = true
vim.opt.numberwidth = 8
vim.opt.pumheight = 12
vim.opt.scrolloff = 8
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.textwidth = 73
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.wrapmargin = 73

vim.cmd.colorscheme("vim")

-- environment variables

-- $CONFIG
vim.env.CONFIG = vim.fn.stdpath("config")

-- $OPTIONS
vim.env.OPTIONS = vim.env.CONFIG .. "/lua/core/options.lua"

-- $LAZY
vim.env.LAZY = vim.env.CONFIG .. "/lua/core/lazy.lua"

-- $PLUGINS
vim.env.PLUGINS = vim.env.CONFIG .. "/lua/plugins"

-- $KEYMAPS
vim.env.KEYMAPS = vim.env.CONFIG .. "/lua/core/keymaps.lua"

-- $AUTOCMDS
vim.env.AUTOCMDS = vim.env.CONFIG .. "/lua/core/autocmds.lua"

-- $LSP
vim.env.LSP = vim.env.CONFIG .. "/lua/plugins/lsp.lua"

-- $FTPLUGIN
vim.env.FTPLUGIN = vim.env.CONFIG .. "/after/ftplugin"
