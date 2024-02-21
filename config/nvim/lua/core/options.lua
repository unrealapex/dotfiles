-- automatic indentation
vim.opt.autoindent = true
-- reread file if it has been modified outside of Vim
vim.opt.autoread = true
-- set window background to dark
vim.opt.background = "dark"
-- more powerful backspacing
vim.opt.backspace = "indent,eol,start"
-- store all backup files in one directory
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
-- sync with system clipboard
vim.opt.clipboard = "unnamedplus"
-- enter the current millennium
vim.opt.compatible = false
vim.opt.completeopt = "menu,menuone,noselect"
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
-- allow hidden buffers
vim.opt.hidden = true
vim.opt.history = 500
-- ignore case unless explicitly stated
vim.opt.ignorecase = true
-- incremental search
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = { leadmultispace = "│ " }
vim.opt.magic = true
-- show line numbers
vim.opt.number = true
-- basic completion
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.path:append(".,**")
vim.opt.pumheight = 15
-- show relative line numbers
vim.opt.relativenumber = true
-- show cursor position in status bar
vim.opt.ruler = true
-- 8 lines above or below cursor when scrolling
vim.opt.scrolloff = 8
-- indents to next multiple of 'shiftwidth'.
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.showmode = false
-- show typed command in status bar
vim.opt.showcmd = true
vim.opt.signcolumn = "auto:1-2"
vim.opt.smartcase = true
-- put new windows right of the current
vim.opt.splitright = true
-- set tabs to two spaces
vim.opt.tabstop = 2
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
vim.opt.winbar = "%=%m %f"
-- don't wrap lines
vim.opt.wrap = false

-- syntax highlighting
vim.cmd([[syntax on]])

-- make gutter match background color
vim.cmd([[highlight clear SignColumn]])

--globals

-- enable filetype.lua
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- set the mapleader to space
vim.g.mapleader = " "

vim.g["rainbow#pairs"] = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

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
    if vim.fn.exists(":ZenMode") == 2 then
      vim.cmd([[ZenMode]])
    end
    vim.notify("Prose Mode Enabled")
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
    if vim.fn.exists(":ZenMode") == 2 then
      vim.cmd([[ZenMode]])
    end
    vim.notify("Prose Mode Disabled")
  end
end

vim.api.nvim_create_user_command("Prose", prose, {})

-- environment variables

-- $CONFIG
vim.env.CONFIG = vim.fn.stdpath("config")

-- handle os file path variations
if vim.fn.has("unix") == 1 then
  -- $OPTIONS
  vim.env.OPTIONS = vim.fn.stdpath("config") .. "/lua/core/options.lua"

  -- $LAZY
  vim.env.LAZY = vim.fn.stdpath("config") .. "/lua/core/lazy.lua"

  -- $PLUGINS
  vim.env.PLUGINS = vim.fn.stdpath("config") .. "/lua/core/plugins.lua"

  -- $KEYMAPS
  vim.env.KEYMAPS = vim.fn.stdpath("config") .. "/lua/core/keymaps.lua"

  -- $AUTOCMDS
  vim.env.AUTOCMDS = vim.fn.stdpath("config") .. "/lua/core/autocmds.lua"

  -- $LSP
  vim.env.LSP = vim.fn.stdpath("config") .. "/lua/plugins/lsp.lua"
elseif vim.fn.has("win32") == 1 then
  -- $OPTIONS
  vim.env.OPTIONS = vim.fn.stdpath("config") .. "\\lua\\core\\options.lua"

  -- $LAZY
  vim.env.LAZY = vim.fn.stdpath("config") .. "\\lua\\core\\lazy.lua"

  -- $PLUGINS
  vim.env.PLUGINS = vim.fn.stdpath("config") .. "\\lua\\core\\plugins.lua"

  -- $KEYMAPS
  vim.env.KEYMAPS = vim.fn.stdpath("config") .. "\\lua\\core\\keymaps.lua"

  -- $AUTOCMDS
  vim.env.AUTOCMDS = vim.fn.stdpath("config") .. "\\lua\\core\\autocmds.lua"

  -- $LSP
  vim.env.LSP = vim.fn.stdpath("config") .. "\\lua\\plugins\\lsp.lua"
else
end
