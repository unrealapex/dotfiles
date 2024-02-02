return {
  -- nicer ui
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
      },
    },
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
  -- better file explorer
  {
    "justinmk/vim-dirvish",
    keys = "-",
    cmd = "Dirvish",
    init = function()
      -- check if a file argument supplied is a directory
      local argv_contains_dir = false
      ---@diagnostic disable-next-line: unused-local
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
    end,
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
    },
  },
  -- rsi style mappings
  { "tpope/vim-rsi", event = { "InsertEnter", "CmdlineEnter" } },
  -- move text
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
      { "<A-l>", mode = "v" },
    },
    config = function()
      require("mini.move").setup()
    end,
  },
  -- unimpaired mappings
  { "tpope/vim-unimpaired", keys = { "[", "]" } },
  -- better git integration
  {
    "lewis6991/gitsigns.nvim",
    cond = vim.fn.executable("git") == 1,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.gitsigns")
    end,
  },
  -- status bar
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.lualine")
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
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
      "GBrowse",
    },
    ft = { "fugitive" },
  },
  -- surround
  {
    "kylechui/nvim-surround",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = "VeryLazy",
    config = true,
  },
  -- repeat plugin commands
  { "tpope/vim-repeat", event = "VeryLazy" },
  -- git commit browser
  {
    "sindrets/diffview.nvim",
    cond = vim.fn.executable("git") == 1 or vim.fn.executable("mercurial") == 1,
    cmd = {
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewLog",
      "DiffviewOpen",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- commenter
  {
    "numToStr/Comment.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = { "gc", "gb", { "gc", mode = "v" }, { "gb", mode = "v" } },
    config = true,
  },
  -- zen mode
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>z",
        function()
          require("zen-mode").toggle()
        end,
      },
    },
    cmd = { "ZenMode" },
    config = true,
  },
  -- parentheses colorizer
  {
    "junegunn/rainbow_parentheses.vim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.cmd([[RainbowParentheses]])
    end,
  },
  -- lsp and completion stuff
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.lsp")
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    config = true,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "neovim/nvim-lspconfig",
        opts = {
          automatic_installation = true,
        },
      },
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    cmd = "Lspsaga",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      diagnostic = {
        on_insert = false,
      },
      lightbulb = {
        sign = false,
      },
      rename = {
        keys = {
          quit = { "q", "<ESC>" },
        },
      },
    },
    keys = {
      { "gh", "<cmd>Lspsaga lsp_finder<CR>" },
      { "<leader>ca", mode = { "n", "v" }, "<cmd>Lspsaga code_action<CR>" },
      { "<leader>rn", "<cmd>Lspsaga rename<CR>" },
      { "<leader>Rn", "<cmd>Lspsaga rename ++project<CR>" },
      { "gd", "<cmd>Lspsaga goto_definition<CR>" },
      { "gD", "<cmd>Lspsaga peek_definition<CR>" },
      { "gt", "<cmd>Lspsaga goto_type_definition<CR>" },
      { "gT", "<cmd>Lspsaga peek_type_definition<CR>" },
      { "gl", "<cmd>Lspsaga show_line_diagnostics<CR>" },
      { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
      { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>" },
      {
        "[E",
        function()
          require("lspsaga.diagnostic").goto_prev({
            severity = vim.diagnostic.severity.ERROR,
          })
        end,
      },
      {
        "]E",
        function()
          require("lspsaga.diagnostic").goto_next({
            severity = vim.diagnostic.severity.ERROR,
          })
        end,
      },
      { "<leader>o", "<cmd>Lspsaga outline<CR>" },
      { "K", "<cmd>Lspsaga hover_doc<CR>" },
      {
        "<A-d>",
        mode = { "n", "v" },
        "<cmd>Lspsaga term_toggle<CR>",
      },
    },
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
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = "hrsh7th/nvim-cmp",
  },
  {
    "hrsh7th/cmp-nvim-lua",
    ft = "lua",
    dependencies = "hrsh7th/nvim-cmp",
  },
  {
    "hrsh7th/cmp-calc",
    event = { "InsertEnter" },
    dependencies = "hrsh7th/nvim-cmp",
  },
  {
    "hrsh7th/cmp-emoji",
    keys = { ":", mode = "i" },
    dependencies = "hrsh7th/nvim-cmp",
  },
  {
    "zbirenbaum/copilot-cmp",
    event = { "InsertEnter" },
    config = true,
    dependencies = {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      cond = vim.fn.executable("node") == 1,
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end,
    },
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
        end,
      },
    },
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
    end,
  },
  -- formatter
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format()
        end,
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        python = {
          formatters = { "isort", "black" },
          run_all_formatters = true,
        },
        sh = { "shfmt" },
        json = { "jq" },
        java = { "google-java-format" },
        c = { "clang-format" },
        cs = { "clang-format" },
        cpp = { "clang-format" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "--indent", "2" },
        },
      },
    },
  },
  -- java lsp stuff
  { "mfussenegger/nvim-jdtls", ft = "java" },
  -- lsp window
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>q", "<cmd>Trouble<CR>" },
    },
  },
  -- improved syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cond = (
      vim.fn.executable("git") == 1
      or (vim.fn.executable("curl") == 1 and vim.fn.executable("tar") == 1)
    ),
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
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
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
      { "'", mode = "i" },
    },
    config = true,
  },
  -- start screen
  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    init = function()
      if vim.fn.argc() == 0 then
        vim.cmd([[
        autocmd UIEnter * :Alpha
        ]])
      end
    end,
    config = function()
      require("plugins.alpha")
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  -- fuzzy finder
  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
      },
      {
        "<leader>fg",
        function()
          require("fzf-lua").live_grep()
        end,
      },
      {
        "<leader><leader>",
        function()
          require("fzf-lua").buffers()
        end,
      },
      {
        "<leader>fh",
        function()
          require("fzf-lua").help_tags()
        end,
      },
      {
        "<leader>fd",
        function()
          require("fzf-lua").diagnostics_document()
        end,
      },
      {
        "<leader>fo",
        function()
          require("fzf-lua").oldfiles()
        end,
      },
    },
    cmd = { "FzfLua" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("fzf-lua").setup({
        "telescope",
      })
    end,
  },
  -- additional text objects
  {
    "wellle/targets.vim",
    event = "VeryLazy",
  },
  -- heuristically set buffer options
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  -- icons
  "nvim-tree/nvim-web-devicons",
  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
      })
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  -- markdown preview
  {
    "ellisonleao/glow.nvim",
    cond = vim.fn.executable("glow") == 1,
    ft = "markdown",
    config = true,
  },
  -- color previews
  {
    "NvChad/nvim-colorizer.lua",
    ft = {
      "cfg",
      "conf",
      "css",
      "dosini",
      "html",
      "javascript",
      "sass",
      "sh",
      "zsh",
    },
    config = function()
      require("colorizer").setup({
        filetypes = {
          "cfg",
          "conf",
          "css",
          "dosini",
          "html",
          "javascript",
          "sass",
          "sh",
          "zsh",
        },
      })
    end,
  },
}
