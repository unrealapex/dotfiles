---@diagnostic disable: different-requires, mixed_table, undefined-field
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
  {
    "tpope/vim-rsi",
    keys = {
      { "<C-a>", mode = { "c", "i" } },
      { "<C-x><C-a>", mode = { "c", "i" } },
      { "<C-b>", mode = { "c", "i" } },
      { "<C-d>", mode = { "c", "i" } },
      { "<C-e>", mode = { "c", "i" } },
      { "<C-f>", mode = { "c", "i" } },
      { "<C-g>", mode = { "c", "i" } },
      { "<C-t>", mode = { "c", "i" } },
      { "<M-BS>", mode = { "c", "i" } },
      { "<M-b>", mode = { "c", "i" } },
      { "<M-d>", mode = { "c", "i" } },
      { "<M-f>", mode = { "c", "i" } },
      { "<M-n>", mode = { "c", "i" } },
      { "<C-p>", mode = { "c", "i" } },
    },
  },
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
  {
    "tpope/vim-unimpaired",
    keys = {
      { "[", mode = { "n", "v" } },
      { "]", mode = { "n", "v" } },
      -- NOTE: lazy loading a large number of keymaps causes input latency for said keymap's mode
      "y",
    },
  },
  -- better git integration
  {
    "lewis6991/gitsigns.nvim",
    cond = vim.fn.executable("git") == 1,
    -- NOTE: loading this plugin is faster than checking if current buffer is
    -- under version control so just load on buffer events
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      -- Gitsigns mappings

      require("gitsigns").setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = "▎",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = "󰐊",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            hl = "GitSignsDelete",
            text = "󰐊",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        on_attach = function(bufnr)
          -- hunk navigation
          vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              package.loaded.gitsigns.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              package.loaded.gitsigns.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- stage hunk
          vim.keymap.set({ "n", "v" }, "<leader>hs", function()
            package.loaded.gitsigns.stage_buffer()
            vim.notify("staged hunk")
          end)
          -- reset hunk
          vim.keymap.set({ "n", "v" }, "<leader>hr", function()
            package.loaded.gitsigns.reset_hunk()
            vim.notify("reset hunk")
          end)
          -- stage buffer
          vim.keymap.set("n", "<leader>hS", function()
            package.loaded.gitsigns.stage_buffer()
            vim.notify("staged buffer")
          end)
          -- undo stage hunk
          vim.keymap.set("n", "<leader>hu", function()
            package.loaded.gitsigns.undo_stage_hunk()
            vim.notify("undid stage hunk")
          end)
          -- reset buffer
          vim.keymap.set("n", "<leader>hR", function()
            package.loaded.gitsigns.reset_buffer()
            vim.notify("reset buffer")
          end)
          -- preview
          vim.keymap.set("n", "<leader>hp", function()
            package.loaded.gitsigns.preview_hunk()
            vim.notify("preview hunk")
          end)
          -- line blame
          vim.keymap.set("n", "<leader>hb", function()
            package.loaded.gitsigns.blame_line({ full = true })
          end)
          -- current line blame
          vim.keymap.set(
          "n",
          "<leader>tb",
          package.loaded.gitsigns.toggle_current_line_blame
          )
          -- diff
          vim.keymap.set("n", "<leader>hd", package.loaded.gitsigns.diffthis)
          vim.keymap.set("n", "<leader>hD", function()
            package.loaded.gitsigns.diffthis("~")
          end)
          -- show deleted lines
          vim.keymap.set("n", "<leader>td", package.loaded.gitsigns.toggle_deleted)

          -- in hunk text object
          vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
          relative_time = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        yadm = {
          enable = false,
        },
      })
    end,
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
    keys = {
      "ys",
      "yS",
      "ds",
      "cs",
      "cS",
      { "S", mode = "v" },
      { "gS", mode = "v" },
      { "<C-g>s", mode = "i" },
      { "<C-g>S", mode = "i" },
    },
    config = true,
  },
  -- repeat plugin commands
  {
    "tpope/vim-repeat",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },
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
  -- FIXME: this plugin doesn't work with treesitter
  -- parentheses colorizer
  -- {
  --   "junegunn/rainbow_parentheses.vim",
  --   event = { "BufReadPost", "BufNewFile" },
  --   config = function()
  --     vim.cmd.RainbowParentheses()
  --   end,
  -- },
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
    -- FIXME: using event makes lsp not attach to buffers
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = {
      "LspInfo",
      "LspStart",
      "LspStop",
      "LspRestart",
      "LspLog",
    },
    config = function()
      ---@diagnostic disable: unused-local
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
          border = "rounded",
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "clangd",
          "cssls",
          "html",
          "jdtls",
          "jsonls",
          "lua_ls",
          "pyright",
          "sqlls",
          "tsserver",
          "vimls",
        },
      })


      local ensure_installed_formatters = {
        "black",
        "clang-format",
        "google-java-format",
        "isort",
        "jq",
        "prettier",
        "prettierd",
        "shfmt",
        "stylua",
      }

      for _, pkg_name in ipairs(ensure_installed_formatters) do
        local ok, pkg = pcall(require("mason-registry").get_package, pkg_name)
        if ok then
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end

      -- Setup lspconfig.
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      -- require("lspconfig")["<YOUR_LSP_SERVER>"].setup {
      --   capabilities = capabilities
      -- }

      -- lspconfig mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      -- redundtant with inline diagnostics but keeping anyways
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev({ float = false })
      end, opts)
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next({ float = false })
      end, opts)
      vim.keymap.set("n", "<space>;", vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local lsp_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set({ "n", "v" }, "<space>ca", function()
          vim.lsp.buf.code_action({
            context = { only = { "quickfix", "refactor", "source" } },
          })
        end, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      end

      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
          })
        end,
      })

      require("mason-lspconfig").setup_handlers({
        lspconfig["clangd"].setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,

          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
          },
        }),

        lspconfig["bashls"].setup({
          filetypes = { "sh", "zsh" },
        }),
      })

      -- diagnostic text highlight is given to the line number
      for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
        vim.fn.sign_define("DiagnosticSign" .. diag, {
          text = "",
          texthl = "DiagnosticSign" .. diag,
          linehl = "",
          numhl = "DiagnosticSign" .. diag,
        })
      end

      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
      })

      -- NOTE: maybe disable gutter signs entirely
      -- vim.diagnostic.config({signs = false})
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
        cmd = {
          "LspInstall",
          "LspUninstall",
        },
        opts = {
          automatic_installation = true,
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("cmp")

      -- Setup nvim-cmp.
      local cmp = require("cmp")

      -- cmp icons
      local kind_icons = {
        Text = "󰉿",
        Method = "m",
        Function = "󰊕",
        Constructor = "",
        Field = "",
        Variable = "󰆧",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "󰇽",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
      }

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "kind", "abbr" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "calc" },
          { name = "emoji" },
          { name = "luasnip" }, -- For luasnip users.
          -- { name = "ultisnips" }, -- For ultisnips users.
          -- { name = "snippy" }, -- For snippy users.
        }, {
          { name = "buffer" },
        }),
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = "hrsh7th/nvim-cmp",
  },
  {
    "hrsh7th/cmp-buffer",
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = "hrsh7th/nvim-cmp",
  },
  {
    "hrsh7th/cmp-path",
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = "hrsh7th/nvim-cmp",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "LspAttach",
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
    "saadparwaiz1/cmp_luasnip",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip/loaders/from_vscode").lazy_load()
          end,
        },
        config = function()
          require("luasnip")
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
        mode = { "n", "v" },
      },
    },
    opts = {
      -- TODO: make sure these formatters are installed
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
  -- linting
  {
    "mfussenegger/nvim-lint",
    event = "LspAttach",
    opts = {
      linters_by_ft = {
        c = { "cpplint" },
        cpp = { "cpplint" },
        javascript = { "eslint_d" },
        lua = { "selene" },
        luau = { "selene" },
        python = { "flake8" },
        sh = { "shellcheck" },
        typescript = { "eslint_d" },
        vimscript = { "vint" },
        zsh = { "shellcheck" },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd(
      { "BufWritePost", "BufReadPost", "InsertLeave" },
      {
        callback = function()
          -- FIXME: this condition does not work
          if not vim.bo.filetype == "" then
            require("lint").try_lint()
          end
        end,
      }
      )
    end,
  },
  -- java lsp stuff
  { "mfussenegger/nvim-jdtls", ft = "java" },

  -- code action lightbulbs
  -- {
  --   "kosayoda/nvim-lightbulb",
  --   event = "LspAttach",
  --   opts = {
  --     -- TODO: maybe use your own autocmd
  --     autocmd = {
  --       enabled = true,
  --       updatetime = 10,
  --     },
  --     sign = {
  --       enabled = false,
  --     },
  --     virtual_text = {
  --       enabled = true,
  --     },
  --   }
  -- },
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
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
    config = function()
      ---@diagnostic disable: missing-fields
      -- treesitter stuff
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "bash",
          "bibtex",
          "c",
          "comment",
          "cpp",
          "css",
          "diff",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "html",
          "java",
          "javascript",
          "jq",
          "jsdoc",
          "json",
          "jsonc",
          "latex",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "perl",
          "python",
          "query",
          "r",
          "regex",
          "rst",
          "sql",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
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
          end,
        },
        indent = { enable = true, disable = { "yaml" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "+",
            node_incremental = "+",
            scope_incremental = false,
            node_decremental = "_",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              -- NOTE: maybe change these back to @function
              ["af"] = "@block.outer",
              ["if"] = "@block.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
      })
      -- hack to make rainbow_parentheses work with treesitter
      vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "" })
    end,
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
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
      },
    },
    cmd = { "FzfLua" },
    cond = vim.fn.executable("fzf") == 1,
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
            ["png"] = { "chafa" },
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
        "<leader>qs",
        function()
          require("persistence").load()
        end,
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
      },
    },
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      options = vim.opt.sessionoptions:get(),
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
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "williamboman/mason.nvim",
        opts = {
          automatic_installation = true,
        },
      },
      {
        "rcarriga/nvim-dap-ui",
        dependencies = "nvim-neotest/nvim-nio",
      },
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
      local dap = require("dap")
      local dapui = require("dapui")

      ---@diagnostic disable-next-line: missing-fields
      require("mason-nvim-dap").setup({
        automatic_setup = true,
        handlers = {},
        ensure_installed = {
          "bash-debug-adapter",
          "java-debug-adapter",
          "firefox-debug-adapter",
          "debugpy",
          "cpptools",
        },
      })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      -- TODO: test this setup/possibly modify
      ---@diagnostic disable-next-line: missing-fields
      dapui.setup({
        active = true,
        on_config_done = nil,
        breakpoint = {
          text = "",
          texthl = "DiagnosticSignError",
          linehl = "",
          numhl = "",
        },
        breakpoint_rejected = {
          text = "",
          texthl = "DiagnosticSignError",
          linehl = "",
          numhl = "",
        },
        stopped = {
          text = "",
          texthl = "DiagnosticSignWarn",
          linehl = "Visual",
          numhl = "DiagnosticSignWarn",
        },
        log = {
          level = "info",
        },
        ui = {
          auto_open = true,
          notify = {
            threshold = vim.log.levels.INFO,
          },
          config = {
            icons = { expanded = "", collapsed = "", circular = "" },
            mappings = {
              -- Use a table to apply multiple mappings
              expand = { "<CR>", "<2-LeftMouse>" },
              open = "o",
              remove = "d",
              edit = "e",
              repl = "r",
              toggle = "t",
            },
            -- Use this to override mappings for specific elements
            element_mappings = {},
            expand_lines = true,
            layouts = {
              {
                elements = {
                  { id = "scopes", size = 0.33 },
                  { id = "breakpoints", size = 0.17 },
                  { id = "stacks", size = 0.25 },
                  { id = "watches", size = 0.25 },
                },
                size = 0.33,
                position = "right",
              },
              {
                elements = {
                  { id = "repl", size = 0.45 },
                  { id = "console", size = 0.55 },
                },
                size = 0.27,
                position = "bottom",
              },
            },
            controls = {
              enabled = true,
              -- Display controls in this element
              element = "repl",
              icons = {
                pause = "",
                play = "",
                step_into = "",
                step_over = "",
                step_out = "",
                step_back = "",
                run_last = "",
                terminate = "",
              },
            },
            floating = {
              max_height = 0.9,
              max_width = 0.5, -- Floats will be treated as percentage of your screen.
              border = "rounded",
              mappings = {
                close = { "q", "<Esc>" },
              },
            },
            windows = { indent = 1 },
            render = {
              max_type_length = nil, -- Can be integer or nil.
              max_value_lines = 100, -- Can be integer or nil.
            },
          },
        },
      })

      vim.fn.sign_define(
      "DapBreakpoint",
      { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
      "DapStopped",
      { text = "", texthl = "WarningMsg", linehl = "", numhl = "" }
      )

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Install golang specific config
      -- require('dap-go').setup()

      dap.adapters.nlua = function(callback, conf)
        local adapter = {
          type = "server",
          host = conf.host or "127.0.0.1",
          port = conf.port or 8086,
        }
        if conf.start_neovim then
          local dap_run = dap.run
          dap.run = function(c)
            adapter.port = c.port
            adapter.host = c.host
          end
          require("osv").run_this()
          dap.run = dap_run
        end
        callback(adapter)
      end
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Run this file",
          start_neovim = {},
        },
        {
          -- TODO: this doesn't work for some reason
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance (port = 8086)",
          port = 8086,
        },
      }

      dap.adapters.bashdb = {
        type = "executable",
        command = vim.fn.stdpath("data")
        .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
        name = "bashdb",
      }
      dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data")
        .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }

      dap.adapters.java = function(callback)
        -- FIXME:
        -- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
        -- The response to the command must be the `port` used below
        callback({
          type = "server",
          host = "127.0.0.1",
          port = port,
        })
      end

      dap.adapters.firefox = {
        type = "executable",
        command = "node",
        args = {
          os.getenv("HOME")
          .. "/mason/packages/vscode-firefox-debug/dist/adapter.bundle.js",
        },
      }

      dap.configurations.typescript = {
        {
          name = "Debug with Firefox",
          type = "firefox",
          request = "launch",
          reAttach = true,
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          firefoxExecutable = "/usr/bin/firefox",
        },
      }
    end,
  },
  -- additional text objects
  {
    "echasnovski/mini.ai",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter(
          { a = "@function.outer", i = "@function.inner" },
          {}
          ),
          c = ai.gen_spec.treesitter(
          { a = "@class.outer", i = "@class.inner" },
          {}
          ),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
          {
            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]",
          },
          "^().*()$",
        },
        g = function() -- Whole buffer, similar to `gg` and 'G' motion
          local from = { line = 1, col = 1 }
          local to = {
            line = vim.fn.line("$"),
            col = math.max(vim.fn.getline("$"):len(), 1),
          }
          return { from = from, to = to }
        end,
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      },
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)
  end,
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
      on_highlights = function(highlights, colors)
        highlights.StatusLine = colors.Normal
        highlights.StatusLineNC = colors.Normal
        highlights.WinBar = {
          bg = colors.none,
        }
        highlights.WinBarNC = {
          bg = colors.none,
        }
      end,
    })
    vim.cmd.colorscheme("tokyonight-night")
  end,
},
-- markdown preview
{
  "ellisonleao/glow.nvim",
  cond = vim.fn.executable("glow") == 1,
  cmd = "Glow",
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
