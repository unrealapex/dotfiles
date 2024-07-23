---@diagnostic disable: different-requires, mixed_table, undefined-field

return {

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
          { name = "luasnip" },
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
      "echasnovski/mini.icons",
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

  -- automatically close pairs
  {
    "windwp/nvim-autopairs",
    -- load when bracket delimiter is pressed
    keys = {
      { "(", mode = "i" },
      { "{", mode = "i" },
      { "[", mode = "i" },
      { ")", mode = "i" },
      { "}", mode = "i" },
      { "]", mode = "i" },
      { '"', mode = "i" },
      { "'", mode = "i" },
      { "`", mode = "i" },
    },
    config = true,
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
}
