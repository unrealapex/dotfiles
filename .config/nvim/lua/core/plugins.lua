-- plugins
return {
  -- better file explorer
  'justinmk/vim-dirvish',
  -- unix helpers
  {
    'tpope/vim-eunuch',
    lazy = true,
    cmd = {
      'Remove',
      'Unlink',
      'Delete',
      'Copy',
      'Duplicate',
      'Move',
      'Rename',
      'Chmod',
      'Mkdir',
      'Cfind',
      'Lfind',
      'Clocate',
      'Llocate',
      'SudoEdit',
      'SudoWrite',
      'Wall',
      'W',
    }
  },
  {
    'tpope/vim-rsi',
    lazy = true,
    event = {'InsertEnter', 'CmdlineEnter'}
  },
  {
    'echasnovski/mini.move',
    keys = {
      '<A-h>',
      '<A-j>',
      '<A-k>',
      '<A-l>',
      { '<A-h>', mode = 'v' },
      { '<A-j>', mode = 'v' },
      { '<A-k>', mode = 'v' },
      { '<A-l>', mode = 'v' }
    },
    config = function()
      require('mini.move').setup()
    end
  },
  {
    'tpope/vim-unimpaired',
    keys = { '[', ']' }
  },
  -- better git integration
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.gitsigns')
    end
  },
  -- status bar
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('plugins.lualine')
    end
  },
  -- conveniently run git commands from vim
  {
    'tpope/vim-fugitive',
    lazy = true,
    cmd = { 'G' }
  },
  {
    'tpope/vim-surround',
    keys = { "ds", "cs", "ys", { "S", mode = 'v' }, { "gS", mode = 'v' } }
  },
  -- TODO: integrate repeat with other plugins
  {
    'tpope/vim-repeat',
    lazy = true,
    event = 'VeryLazy'
  },
  -- git commit browser
  {
    'junegunn/gv.vim',
    lazy = true,
    cmd = { 'GV' },
    dependencies = { 'tpope/vim-fugitive' }
  },
  -- commenter
  {
    'numToStr/Comment.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = { "gc", "gb", { "gc", mode = 'v' }, { "gb", mode = 'v' } },
    config = true,
  },
  -- indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
        show_current_context_start = true,
      })
    end
  },
  -- zen mode
  {
    'folke/zen-mode.nvim',
    lazy = true,
    cmd = { 'ZenMode' },
    config = true,
  },
  -- parentheses colorizer
  {
    'junegunn/rainbow_parentheses.vim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.cmd [[RainbowParentheses]]
    end
  },
  -- turn off search highlighting automatically
  {
    'romainl/vim-cool',
    -- load vim-cool when doing a search
    keys = {
      "/",
      "?",
      "n",
      "N",
      "*",
      "#",
      { "*", mode = 'v' },
      { "#", mode = 'v' },
      "g*",
      "g#",
    }
  },
  -- completion + lsp
  {
    'neoclide/coc.nvim',
    branch = 'release',
    lazy = true,
    event = { 'VeryLazy' },
    dependencies = 'honza/vim-snippets',
    build = 'python -m pip install --user --upgrade pynvim',
    config = function()
      require('plugins.coc')
    end
  },
  -- improved syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = true,
    event = { 'VeryLazy' },
    cmd = {
      'TSBufDisable',
      'TSBufEnable',
      'TSBufToggle',
      'TSConfigInfo',
      'TSDisable',
      'TSEditQuery',
      'TSEditQueryUserAfter',
      'TSEnable',
      'TSInstall',
      'TSInstallFromGrammar',
      'TSInstallInfo',
      'TSInstallSync',
      'TSModuleInfo',
      'TSToggle',
      'TSUninstall',
      'TSUpdate',
      'TSUpdateSync',
    },
    config = function()
      -- treesitter stuff
      local configs = require("nvim-treesitter.configs")
      configs.setup {
        ensure_installed = "all",
        sync_install = false,
        ignore_install = { "" }, -- List of parsers to ignore installing
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "" }, -- list of language that will be disabled
        },
        indent = { enable = true, disable = { "yaml" } },
      }
      -- hack to make rainbow_parentheses work with treesitter
      vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "" })
    end
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    opt = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('treesitter-context').setup({
        enable = true,
        mode = 'cursor',
      })
      vim.cmd[[TSContextEnable]]
    end,
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },

  -- automatically close pairs
  {
    "windwp/nvim-autopairs",
    -- load when starting bracket delimiter is pressed
    keys = {
      { '(', mode = 'i' },
      { '{', mode = 'i' },
      { '[', mode = 'i' },
      { '"', mode = 'i' },
      { "'", mode = 'i' }
    },
    config = true,
  },

  -- start screen
  {
    'goolord/alpha-nvim',
    config = function()
      require('plugins.alpha')
    end
  },
  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = { 'Telescope' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        -- increase telescope search speed
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      }
    },
    config = function()
      require("plugins.telescope")
    end
  },

  -- improved movement
  {
    'ggandor/leap.nvim',
    keys = { 's', 'S', { 's', mode = 'v' }, { 'S', mode = 'v' }, 'gs' },
    config = function()
      require('leap').set_default_keymaps()
    end
  },

  {
    'wellle/targets.vim',
    lazy = true,
    event = 'VeryLazy'
  },
  -- icons
  'nvim-tree/nvim-web-devicons',
  -- colorscheme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end
  },
  -- markdown preview
  {
    'ellisonleao/glow.nvim',
    lazy = true,
    ft = 'markdown'
  }
}
