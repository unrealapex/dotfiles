---@diagnostic disable: different-requires, mixed_table
return {
  -- nicer ui
  {
    "stevearc/dressing.nvim",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
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
    dependencies = "bounceme/remote-viewer",
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
    config = true,
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
      vim.cmd.RainbowParentheses()
    end,
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
    },
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
    keys = {
      {
        "<leader>m",
        function()
          vim.cmd.Mason()
        end,
      },
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
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
          automatic_installation = true,
        },
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
    "hrsh7th/cmp-nvim-lsp-signature-help",
    -- TODO: change this to a better event
    event = "InsertEnter",
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
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format()
        end,
      },
      mode = { "n", "v" },
      config = function ()
        require("plugins.conform")
      end
    },
  },
  -- linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.lint")
    end,
  },
  -- java lsp stuff
  { "mfussenegger/nvim-jdtls", ft = "java" },

  -- code action lightbulbs
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      -- TODO: maybe use your own autocmd
      autocmd = {
        enabled = true,
        updatetime = 10,
      },
      sign = {
        enabled = false,
      },
      virtual_text = {
        enabled = true,
      },
    }
  },
  -- lsp window
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      {
        "<leader>q",
        function()
          vim.cmd.Trouble()
        end,
      },
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
      {
        "<leader>fs",
        function ()
          require("fzf-lua").lsp_document_symbols()
        end
      },
    },
    cmd = { "FzfLua" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      "telescope",
      previewers = {
        builtin = {
          extensions = {
            -- neovim terminal only supports `viu` block output
            ["gif"] = { "chafa" },
            ["jpg"] = { "chafa" },
            ["png"] = { "chafa"},
            ["webp"] = { "chafa" },
          },
        },
      },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      {
        "<leader>qs", function()
          require("persistence").load()
        end
      },
      {"<leader>ql", function()
        require("persistence").load({ last = true })
      end
      },
      {"<leader>qd", function ()
        require("persistence").stop()
      end}
    },

    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      options = vim.opt.sessionoptions:get(),
    }
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {
      {
        "<C-`>", function()
        vim.cmd.ToggleTerm()
      end
      }
    },
    opts = {
  open_mapping = [[<c-`>]],
  autochdir = true,
    },
  },
  -- debugging
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
      },
      {
        "<F1>",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<F2>",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<F3>",
        function()
          require("dap").step_out()
        end,
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
      },
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
      },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
      },
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
      },
      {
        "<leader>ds",
        function()
          require("dap.ui.widgets").scopes()
        end,
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
      },
      {
        "<leader>dq",
        function()
          require("dap").terminate()
        end,
      },
      -- dap ui keymaps
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
      },
      {
        "<leader>de",
        mode = { "n", "v" },
        function()
          require("dapui").eval()
        end,
      },
      {
        "<leader>dE",
        function()
          require("dapui").eval(vim.fn.input("[Expression] > "))
        end,
      },
    },
    cmd = {
      "DapInstall",
      "DapShowLog",
      "DapStepOut",
      "DapContinue",
      "DapStepInto",
      "DapStepOver",
      "DapTerminate",
      "DapUninstall",
      "DapToggleRepl",
      "DapSetLogLevel",
      "DapRestartFrame",
      "DapLoadLaunchJSON",
      "DapToggleBreakpoint",
    },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- TODO: add more debug adapters
      {
        "jbyuki/one-small-step-for-vimkind",
      },
      {
        "mfussenegger/nvim-dap-python",
      },
    },
    config = function()
      ---@diagnostic disable-next-line: different-requires
      require("plugins.dap")
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
      ---@diagnostic disable-next-line: missing-fields
      require("tokyonight").setup({
        transparent = true,
      })
      vim.cmd.colorscheme("tokyonight-night")
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
    -- REFACTOR: get filetypes from ft
    opts = {
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
    },
  },
}
