-- reread file if it has been modified outside of Vim
vim.opt.autoread = true
-- set window background to dark
vim.opt.background = "dark"
-- more powerful backspacing
vim.opt.backspace = "indent,eol,start"
-- store all backup files in one directory
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
vim.opt.cindent = true
vim.opt.cinoptions = "(0"
-- sync with system clipboard
vim.opt.clipboard = "unnamedplus"
-- enter the current millennium
vim.opt.compatible = false
-- enable cursor line
vim.opt.cursorline = true
-- store all swap files in one directory
vim.opt.directory = vim.fn.stdpath("state") .. "/swap"
-- disable annoying error bell
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.formatoptions = "jcroqlnt"
-- enable folding
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.guicursor = ""
-- allow hidden buffers
vim.opt.hidden = true
vim.opt.history = 500
-- ignore case unless explicitly stated
vim.opt.ignorecase = true
-- incremental search
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = nil
vim.opt.magic = true
-- show line numbers
vim.opt.number = true
-- basic completion
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.path:append(".,**")
vim.opt.pumheight = 12
-- show relative line numbers
vim.opt.relativenumber = true
-- show cursor position in status bar
vim.opt.ruler = true
-- 8 lines above or below cursor when scrolling
vim.opt.scrolloff = 8
-- indents to next multiple of 'shiftwidth'.
vim.opt.shiftwidth = 4
-- vim.opt.shiftround = true
vim.opt.showmode = true
-- show typed command in status bar
vim.opt.showcmd = true
vim.opt.signcolumn = "auto:1-2"
vim.opt.smartcase = true
vim.opt.softtabstop = 4
-- put new windows right of the current
vim.opt.splitright = true
-- TODO: show diagnostics
vim.opt.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %P"
-- set tabs to two spaces
-- vim.opt.tabstop = 2
-- true color support
vim.opt.termguicolors = true
-- show file in titlebar
vim.opt.title = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
-- persistent undo tree
vim.opt.undofile = true
vim.opt.undolevels = 500
-- set updatetime to 200 milliseconds
vim.opt.updatetime = 200
vim.opt.visualbell = false
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
-- don't wrap lines
vim.opt.wrap = false

-- syntax highlighting
vim.cmd.syntax("on")

-- colorscheme
vim.cmd.colorscheme("wildcharm")
vim.cmd.highlight({"normal", "guibg=NONE"})

--globals

-- set the mapleader to space
vim.g.mapleader = " "

-- vim.g["rainbow#pairs"] = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

local prosed = false
-- make writing in neovim more pleasant
---@diagnostic disable-next-line: lowercase-global
function prose()
  -- make sure zen-mode.nvim is installed
  -- toggle prose mode
  if not prosed then
    -- enable spellcheck and line wrapping
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.wrap = true

    -- normal and visual mode mappings
    vim.keymap.set({ "n", "v" }, "j", "gj")
    vim.keymap.set({ "n", "v" }, "k", "gk")
    vim.keymap.set({ "n", "v" }, "0", "g0")
    vim.keymap.set({ "n", "v" }, "$", "g$")
    vim.keymap.set({ "n", "v" }, "^", "g^")

    prosed = true
    pcall(vim.cmd.ZenMode())
    vim.notify("prose mode: enabled")
  else
    -- disable spellcheck and line wrapping
    vim.opt_local.spell = false
    vim.opt_local.spelllang = nil
    vim.opt_local.wrap = false

    -- reset normal and visual mode mappings
    vim.keymap.del({ "n", "v" }, "j")
    vim.keymap.del({ "n", "v" }, "k")
    vim.keymap.del({ "n", "v" }, "0")
    vim.keymap.del({ "n", "v" }, "$")
    vim.keymap.del({ "n", "v" }, "^")
    prosed = false
    pcall(vim.cmd.ZenMode())
    vim.notify("prose mode: disabled")
  end
end

vim.api.nvim_create_user_command("Prose", prose, {})

-- environment variables

-- $CONFIG
vim.env.CONFIG = vim.fn.stdpath("config")

-- $OPTIONS
vim.env.OPTIONS = vim.fn.stdpath("config") .. "/lua/core/options.lua"

-- $LAZY
vim.env.LAZY = vim.fn.stdpath("config") .. "/lua/core/lazy.lua"

-- $PLUGINS
vim.env.PLUGINS = vim.fn.stdpath("config") .. "/lua/plugins/"

-- $KEYMAPS
vim.env.KEYMAPS = vim.fn.stdpath("config") .. "/lua/core/keymaps.lua"

-- $AUTOCMDS
vim.env.AUTOCMDS = vim.fn.stdpath("config") .. "/lua/core/autocmds.lua"

-- $LSP
vim.env.LSP = vim.fn.stdpath("config") .. "/lua/plugins/lsp.lua"
