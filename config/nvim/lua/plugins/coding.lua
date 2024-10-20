---@diagnostic disable: different-requires, mixed_table, undefined-field

return {

  {
    "echasnovski/mini.completion",
    event = "InsertEnter",
    opts = {
      lsp_completion = {
        source_func = 'omnifunc',
        auto_setup = false
      },
    },
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
    "echasnovski/mini.bracketed",
    keys = {
      { "[", mode = { "n", "v" } },
      { "]", mode = { "n", "v" } },
      -- NOTE: lazy loading a large number of keymaps causes input latency for said keymap's mode
      "y",
    },
    config = function()
      require("mini.bracketed").setup()
    end,
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
    opts = {
      surrounds = {
        ["("] = {
          add = { "(", ")" },
        },
        ["{"] = {
          add = { "{", " }" },
        },
        ["["] = {
          add = { "[ ", " ]" },
        },
        ["<"] = {
          add = { "< ", " >" },
        },
      },
    },
  },
}
