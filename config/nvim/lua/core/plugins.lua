-- plugins
return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      {
        "rcarriga/nvim-notify",
        keys = {
          {
            "<leader>un",
            function()
              require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Delete all Notifications",
          },
        },
        opts = {
          timeout = 5000,
          max_height = function()
            return math.floor(vim.o.lines * 0.75)
          end,
          max_width = function()
            return math.floor(vim.o.columns * 0.75)
          end,
        },
      }
    },
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        }
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      }
    }
  },
  -- better file explorer
  {
    "justinmk/vim-dirvish",
    keys = "-",
    cmd = "Dirvish",
    init = function()
      -- check if a file argument supplied is a directory
      local argv_contains_dir = false
      for k, v in pairs(vim.fn.argv()) do
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
    "tpope/vim-eunuch",
    cmd = {
      "Remove",
      "Unlink",
      "Delete",
      "Copy",
      "Duplicate",
      "Move",
      "Rename",
      "Chmod",
      "Mkdir",
      "Cfind",
      "Lfind",
      "Clocate",
      "Llocate",
      "SudoEdit",
      "SudoWrite",
      "Wall",
      "W",
    }
  },
  { "tpope/vim-rsi", event = { "InsertEnter", "CmdlineEnter" } },
  {
    "echasnovski/mini.move",
    keys = {
      "<A-h>",
      "<A-j>",
      "<A-k>",
      "<A-l>",
      { "<A-h>", mode = "v" },
      { "<A-j>", mode = "v" },
      { "<A-k>", mode = "v" },
      { "<A-l>", mode = "v" }
    },
    config = function()
      require("mini.move").setup()
    end
  },
  { "tpope/vim-unimpaired", keys = { "[", "]" } },
  -- better git integration
  {
    "lewis6991/gitsigns.nvim",
    cond = vim.fn.executable("git") == 1,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.gitsigns")
    end
  },
  -- status bar
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.lualine")
    end,
    dependencies = "nvim-tree/nvim-web-devicons"
  },
  -- conveniently run git commands from vim
  {
    "tpope/vim-fugitive",
    cond = vim.fn.executable("git") == 1,
    cmd = {
      "G",
      "Git",
      "Ggrep",
      "Glgrep",
      "Gclog",
      "Gllog",
      "Gcd",
      "Glcd",
      "Gedit",
      "Gvsplit",
      "Gtabedit",
      "Gpedit",
      "Gdrop",
      "Gread",
      "Gwrite",
      "Gwq",
      "Gdiffsplit",
      "Ghdiffsplit",
      "GMove",
      "GRename",
      "GDelete",
      "GRemove",
      "GUnlink",
      "GBrowse"
    }
  },
  {
    "tpope/vim-surround",
    keys = { "ds", "cs", "ys", { "sa", "<Plug>VSurround", mode = "v" }, { "gS", mode = "v" } },
    config = function()
      -- remove vim-surround's visual mode mapping for S and use sa instead
      vim.keymap.del("x", "S")
    end
  },
  { "tpope/vim-repeat", event = "VeryLazy" },
  -- git commit browser
  {
    "junegunn/gv.vim",
    cond = vim.fn.executable("git") == 1,
    cmd = { "GV" },
    dependencies = { "tpope/vim-fugitive" }
  },
  -- commenter
  {
    "numToStr/Comment.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = { "gc", "gb", { "gc", mode = "v" }, { "gb", mode = "v" } },
    config = true,
  },
  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      show_current_context = true,
      show_current_context_start = true,
      exclude = {
        filetypes = {
          "''",
          "TelescopePrompt",
          "TelescopeResults",
          "checkhealth",
          "gitcommit",
          "help",
          "lspinfo",
          "man",
          "packer",
          "NvimTree",
          "Trouble",
          "WhichKey",
          "dashboard",
          "help",
          "lsp-installer",
          "mason",
          "neogitstatus",
          "packer",
          "sh",
          "startify",
          "text",
        }
      }

    }
  },
  -- zen mode
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", function() require("zen-mode").toggle() end }
    },
    cmd = { "ZenMode" },
    config = true,
  },
  -- parentheses colorizer
  {
    "junegunn/rainbow_parentheses.vim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.cmd [[RainbowParentheses]]
    end
  },
  -- turn off search highlighting automatically
  {
    "romainl/vim-cool",
    -- load vim-cool when doing a search
    keys = {
      "/",
      "?",
      "n",
      "N",
      "*",
      "#",
      { "*", mode = "v" },
      { "#", mode = "v" },
      "g*",
      "g#",
    }
  },
  -- lsp and completion stuff
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.lsp")
    end
  },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog"
    },
    config = true,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "neovim/nvim-lspconfig",
        opts = {
          automatic_installation = true,
        }
      }
    }
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    cmd = "Lspsaga",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter"
    },
    opts = {
      lightbulb = {
        sign = false
      }
    },
    keys = {
      { "gh",         "<cmd>Lspsaga lsp_finder<CR>" },
      { "<leader>ca", mode = { "n", "v" }, "<cmd>Lspsaga code_action<CR>" },
      { "<leader>rn", "<cmd>Lspsaga rename<CR>" },
      { "<leader>Rn", "<cmd>Lspsaga rename ++project<CR>" },
      { "gd",         "<cmd>Lspsaga goto_definition<CR>" },
      { "gD",         "<cmd>Lspsaga peek_definition<CR>" },
      { "gt",         "<cmd>Lspsaga goto_type_definition<CR>" },
      { "gT",         "<cmd>Lspsaga peek_type_definition<CR>" },
      { "gl",  "<cmd>Lspsaga show_line_diagnostics<CR>" },
      { "[d",         "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
      { "]d",         "<cmd>Lspsaga diagnostic_jump_next<CR>" },
      { "[E",         function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end },
      { "]E",         function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end },
      { "<leader>o",  "<cmd>Lspsaga outline<CR>" },
      { "K",          "<cmd>Lspsaga hover_doc<CR>" },
      { "<A-d>",      mode = { "n", "v" },                                                                                 "<cmd>Lspsaga term_toggle<CR>" }
    }
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "nvim-tree/nvim-web-devicons"
    }
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = "hrsh7th/nvim-cmp"
  },
  {
    "hrsh7th/cmp-nvim-lua",
    ft = "lua",
    dependencies = "hrsh7th/nvim-cmp"
  },
  {
    "hrsh7th/cmp-calc",
    event = { "InsertEnter" },
    dependencies = "hrsh7th/nvim-cmp"
  },
  {
    "hrsh7th/cmp-emoji",
    keys = { ":", mode = "i" },
    dependencies = "hrsh7th/nvim-cmp"
  },
  {
    "f3fora/cmp-spell",
    event = { "InsertEnter" },
    ft = { "markdown", "text", "html", "tex" },
    dependencies = "hrsh7th/nvim-cmp"
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
      require("luasnip")
    end,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip/loaders/from_vscode").lazy_load()
        end
      },
    }
  },
  {
    "folke/neodev.nvim",
    ft = "lua",
    config = function()
      require("neodev").setup()
        vim.lsp.start({
          name = "lua-language-server",
          cmd = { "lua-language-server" },
          before_init = require("neodev.lsp").before_init,
          root_dir = vim.fn.getcwd(),
          settings = { Lua = {} },
        })
    end
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- FIXME: make sure that formatters uses spaces instead of tabs for formatting
        lua = { "stylua" },
        javascript = { "prettier_d", "prettier" },
        typescript = { "prettier_d", "prettier" },
        html = { "prettier_d", "prettier" },
        css = { "prettier_d", "prettier" },
        markdown = { "prettier_d", "prettier" },
        python = {
          formatters = { "isort", "black" },
          run_all_formatters = true,
        },
        sh = {"shfmt"},
        json = {"jq"},
        java = {"google-java-format"},
        c = {"clang-format"},
        cs = {"clang-format"},
        cpp = {"clang-format"}
      }
    }
  },
  { "mfussenegger/nvim-jdtls", ft = "java" },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>q", "<cmd>Trouble<CR>" },
    }
  },
  -- improved syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cond = (vim.fn.executable("git") == 1 or (vim.fn.executable("curl") == 1 and vim.fn.executable("tar") == 1)),
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSConfigInfo",
      "TSDisable",
      "TSEditQuery",
      "TSEditQueryUserAfter",
      "TSEnable",
      "TSInstall",
      "TSInstallFromGrammar",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSToggle",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    init = function()
      if vim.fn.argc() >= 1 then
        require("lazy").load({ plugins = { "nvim-treesitter" } })
      end
    end,
    config = function()
      require("plugins.treesitter")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        mode = "cursor",
      })
      vim.cmd [[TSContextEnable]]
    end,
    dependencies = "nvim-treesitter/nvim-treesitter"
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter"
  },
  -- automatically close pairs
  {
    "windwp/nvim-autopairs",
    -- load when starting bracket delimiter is pressed
    keys = {
      { "(", mode = "i" },
      { "{", mode = "i" },
      { "[", mode = "i" },
      { '"', mode = "i" },
      { "'", mode = "i" }
    },
    config = true,
  },
  -- start screen
  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    init = function()
      if vim.fn.argc() == 0 then
        vim.cmd [[
        autocmd UIEnter * :Alpha
        ]]
      end
    end,
    config = function()
      require("plugins.alpha")
    end,
    dependencies = "nvim-tree/nvim-web-devicons"
  },
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff",       function() require("telescope.builtin").find_files() end },
      { "<leader>fg",       function() require("telescope.builtin").live_grep() end },
      { "<leader><leader>", function() require("telescope.builtin").buffers() end },
      { "<leader>fh",       function() require("telescope.builtin").help_tags() end },
      { "<leader>fd",       function() require("telescope.builtin").diagnostics() end },
      { "<leader>fo",       function() require("telescope.builtin").oldfiles() end },
    },
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      {
        -- increase telescope search speed
        "nvim-telescope/telescope-fzf-native.nvim",
        cond = vim.fn.executable("make") == 1,
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end
      }
    },
    config = function()
      ---@diagnostic disable-next-line: different-requires
      require("plugins.telescope")
    end
  },
  -- improved movement
  {
    "ggandor/leap.nvim",
    keys = {
      { "s",  mode = { "n", "x", "o" } },
      { "S",  mode = { "n", "x", "o" } },
      { "gs", mode = { "n", "x", "o" } },
    },
    config = function()
      require("leap").set_default_keymaps()
    end
  },
  {
    "wellle/targets.vim",
    event = "VeryLazy"
  },
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  -- icons
  "nvim-tree/nvim-web-devicons",
  -- colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        lsp_saga = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        leap = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    config = function()
      vim.cmd [[colorscheme catppuccin-mocha]]
    end
  },
  -- markdown preview
  {
    "ellisonleao/glow.nvim",
    cond = vim.fn.executable("glow") == 1,
    ft = "markdown",
    config = true
  },
  {
    "norcalli/nvim-colorizer.lua",
    ft = {"css", "html", "javascript", "sass"},
    config = function()
      require("colorizer").setup({
        -- make sure that nvim-colorizer only attaches to these file types
        'css';
        'html';
        'javascript';
        'sass';
      })
    end
  }
}
