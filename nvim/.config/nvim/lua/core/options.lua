-- automatic indentation
vim.opt.autoindent = true
-- reread file if it has been modified outside of Vim
vim.opt.autoread = true
-- set window background to dark
vim.opt.background = 'dark'
-- more powerful backspacing
vim.opt.backspace = 'indent,eol,start'
-- store all backup files in one directory
vim.opt.backupdir = vim.fn.expand('~/.vim/swap//')
-- enter the current millennium
vim.opt.compatible = false
vim.opt.completeopt = 'menu,menuone,noselect'
-- enable cursor line
vim.opt.cursorline = true
-- store all swap files in one directory
vim.opt.dir = vim.fn.expand('~/.vim/swap//')
-- disable annoying error bell
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.fo:append('jpor')
-- enable folding
vim.opt.foldenable = false
vim.opt.foldmethod = 'indent'
-- allow hidden buffers
vim.opt.hidden = true
vim.opt.history = 500
-- ignore case unless explicitly stated
vim.opt.ignorecase = true
-- incremental search
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = ''
vim.opt.magic = true
-- show line numbers
vim.opt.number = true
-- basic completion
vim.opt.omnifunc = 'syntaxcomplete#Complete'
vim.opt.path:append('.,**')
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
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
-- set tabs to two spaces
vim.opt.tabstop = 2
vim.opt.termguicolors = true
-- show file in titlebar
vim.opt.title = true
vim.opt.undodir = vim.fn.expand('~/.vim/undo//')
-- persistent undo tree
vim.opt.undofile = true
vim.opt.undolevels = 500
-- set updatetime to 200 milliseconds
vim.opt.updatetime = 200
vim.opt.visualbell = false
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.winbar = '%=%m %f'
-- don't wrap lines
vim.opt.wrap = false

-- syntax highlighting
vim.cmd [[syntax on]]


-- make sure undo and swap file directories exist
if vim.fn.isdirectory('~/.vim/swap') == 0 and vim.fn.isdirectory('~/.vim/undo') == 0 then
  vim.fn.mkdir(vim.fn.expand('~/.vim/swap'), 'p')
  vim.fn.mkdir(vim.fn.expand('~/.vim/undo'), 'p')
elseif vim.fn.isdirectory('~/.vim/swap') == 1 and vim.fn.isdirectory('~/.vim/undo') == 0 then
  vim.fn.mkdir(vim.fn.expand('~/.vim/undo'), 'p')
elseif vim.fn.isdirectory('~/.vim/swap') == 0 and vim.fn.isdirectory('~/.vim/undo') == 1 then
  vim.fn.mkdir(vim.fn.expand('~/.vim/swap'), 'p')
else
end

-- make gutter match background color
vim.cmd [[highlight clear SignColumn]]

-- show whitespaces as characters in visual mode
vim.cmd [[
augroup show_whitespace
  autocmd!
  autocmd ModeChanged *:[vV\x16]* :set listchars+=space:·
  autocmd Modechanged [vV\x16]*:* :set listchars-=space:·
augroup END
]]


--globals

-- enable filetype.lua
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- set the mapleader to space
vim.g.mapleader = ' '

-- declare before indent-blankline is loaded
vim.g.indent_blankline_filetype_exclude = {
  'help',
  'startify',
  'dashboard',
  'packer',
  'neogitstatus',
  'NvimTree',
  'Trouble',
  'WhichKey',
  'lsp-installer',
  'mason',
  'text',
  'sh'
}

vim.g['rainbow#pairs'] = { { '(', ')' }, { '[', ']' }, { '{', '}' } }


function LargeFileHandler()
  vim.notify(
    'Large file detected, disabling certain features for performance reasons',
    vim.log.levels.WARNING
  )
  if vim.fn.exists(':TSBufDisable') then
    vim.cmd [[TSBufDisable highlight]]
    vim.cmd [[TSBufDisable autotag]]
  end
  vim.opt.foldmethod = 'manual'
  vim.cmd [[syntax clear]]
  vim.cmd [[syntax off]]
  vim.cmd [[filetype off]]
  vim.opt.undofile = false
  vim.opt.swapfile = false
end

function LargeFileChecker()
  if vim.fn.getfsize(vim.fn.expand("%")) > (512 * 1024) then
    LargeFileHandler()
  else
  end
end

-- TODO: find a way to make these two autocommands one
vim.cmd [[
  augroup LargeFileDetection
    autocmd!
    autocmd BufReadPre * lua LargeFileChecker()
    autocmd FileReadPre * lua LargeFileChecker()
  augroup END
  ]]


prosed = false
function prose()
  -- make sure zen-mode.nvim is installed
  -- toggle prose mode
  if not prosed then
    -- enable spellcheck and line wrapping
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.wrap = true

    -- normal and visual mode mappings
    vim.keymap.set({'n', 'v'}, 'j', 'gj')
    vim.keymap.set({'n', 'v'}, 'k', 'gk')
    vim.keymap.set({'n', 'v'}, '0', 'g0')
    vim.keymap.set({'n', 'v'}, '$', 'g$')
    vim.keymap.set({'n', 'v'}, '^', 'g^')

    prosed = true
    if vim.fn.exists(':ZenMode') == 2 then
      vim.cmd [[ZenMode]]
    end
    vim.notify('Prose Mode Enabled')
  else
    -- disable spellcheck and line wrapping
    vim.opt_local.spell = false
    vim.opt_local.spelllang = nil
    vim.opt_local.wrap = false

    -- reset normal and visual mode mappings
    vim.keymap.del({'n', 'v'}, 'j')
    vim.keymap.del({'n', 'v'}, 'k')
    vim.keymap.del({'n', 'v'}, '0')
    vim.keymap.del({'n', 'v'}, '$')
    vim.keymap.del({'n', 'v'}, '^')
    prosed = false
    if vim.fn.exists(':ZenMode') == 2 then
      vim.cmd [[ZenMode]]
    end
    vim.notify('Prose Mode Disabled')
  end
end

vim.api.nvim_create_user_command('Prose', prose, {})


-- environment variables

-- $CONFIG
vim.env.CONFIG = vim.fn.stdpath('config')

-- handle os file path variations
if vim.fn.has('unix') == 1 then
  -- $OPTIONS
  vim.env.OPTIONS = vim.fn.stdpath('config') .. "/lua/core/options.lua"

  -- $LAZY
  vim.env.LAZY = vim.fn.stdpath('config') .. "/lua/core/lazy.lua"

  -- $PLUGINS
  vim.env.PLUGINS = vim.fn.stdpath('config') .. "/lua/core/plugins.lua"

  -- $KEYMAPS
  vim.env.KEYMAPS = vim.fn.stdpath('config') .. "/lua/core/keymaps.lua"
elseif vim.fn.has('win32') == 1 then

  -- $OPTIONS
  vim.env.OPTIONS = vim.fn.stdpath('config') .. "\\lua\\core\\options.lua"

  -- $LAZY
  vim.env.LAZY = vim.fn.stdpath('config') .. "\\lua\\core\\lazy.lua"

  -- $PLUGINS
  vim.env.PLUGINS = vim.fn.stdpath('config') .. "\\lua\\core\\plugins.lua"

  -- $KEYMAPS
  vim.env.KEYMAPS = vim.fn.stdpath('config') .. "\\lua\\core\\keymaps.lua"
else
end
