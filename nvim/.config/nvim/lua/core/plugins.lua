-- plugins
return {
  -- better file explorer
  {
    'justinmk/vim-dirvish',
    keys = '-',
    cmd = 'Dirvish',
    init = function()
      -- check if file arguments supplied are directories
      local argv_contains_dir = false
      for v in pairs(vim.fn.argv()) do
        if vim.fn.isdirectory(v) == 1 then
          argv_contains_dir = true
        end
      end
      if vim.fn.argc() >= 1 and argv_contains_dir then
        require("lazy").load({ plugins = { "vim-dirvish" } })
      end
      -- load dirvish when a directory is opened
      vim.api.nvim_create_autocmd("BufNew", {
        callback = function()
          if require("lazy.core.config").plugins["vim-dirvish"]._.loaded then
            return true
          end

          if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
            require("lazy").load({ plugins = { "vim-dirvish" } })
            return true
          end
        end,
      })
    end
  },
  -- unix helpers
  {
    'tpope/vim-eunuch',
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
    event = { 'InsertEnter', 'CmdlineEnter' }
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
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugins.gitsigns')
    end
  },
  -- status bar
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
      require('plugins.lualine')
    end,
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  -- conveniently run git commands from vim
  {
    'tpope/vim-fugitive',
    cmd = {
      'G',
      'Git',
      'Ggrep',
      'Glgrep',
      'Gclog',
      'Gllog',
      'Gcd',
      'Glcd',
      'Gedit',
      'Gvsplit',
      'Gtabedit',
      'Gpedit',
      'Gdrop',
      'Gread',
      'Gwrite',
      'Gwq',
      'Gdiffsplit',
      'Ghdiffsplit',
      'GMove',
      'GRename',
      'GDelete',
      'GRemove',
      'GUnlink',
      'GBrowse'
    }
  },
  {
    'tpope/vim-surround',
    keys = { "ds", "cs", "ys", { "S", mode = 'v' }, { "gS", mode = 'v' } }
  },
  -- TODO: integrate repeat with other plugins
  {
    'tpope/vim-repeat',
    event = 'VeryLazy'
  },
  -- git commit browser
  {
    'junegunn/gv.vim',
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
    event = { 'BufReadPost', 'BufNewFile' },
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
    cmd = { 'ZenMode' },
    config = true,
  },
  -- parentheses colorizer
  {
    'junegunn/rainbow_parentheses.vim',
    event = { 'BufReadPost', 'BufNewFile' },
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
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'honza/vim-snippets',
      'nvim-tree/nvim-web-devicons'
    },
    build = 'python -m pip install --user --upgrade pynvim',
    config = function()
      require('plugins.coc')
    end
  },
  -- improved syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
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
    init = function()
      if vim.fn.argc() >= 1 then
        require("lazy").load({ plugins = { "nvim-treesitter" } })
      end
    end,
    config = function()
      -- treesitter stuff
      local configs = require("nvim-treesitter.configs")
      configs.setup {
        ensure_installed = {
          "bash",
          "c",
          "comment",
          "cpp",
          "css",
          "diff",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "git_rebase",
          "help",
          "html",
          "java",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "r",
          "regex",
          "sql",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        auto_install = true,
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end
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
      vim.cmd [[TSContextEnable]]
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
    event = 'VimEnter',
    config = function()
      require('plugins.alpha')
    end,
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
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
    keys = {
      { "s",  mode = { "n", "x", "o" } },
      { "S",  mode = { "n", "x", "o" } },
      { "gs", mode = { "n", "x", "o" } },
    },
    config = function()
      require('leap').set_default_keymaps()
    end
  },

  {
    'wellle/targets.vim',
    event = 'VeryLazy'
  },
  -- icons
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true
  },
  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme tokyonight-night]]
    end
  },
  -- markdown preview
  {
    'ellisonleao/glow.nvim',
    ft = 'markdown'
  }
}
