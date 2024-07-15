---@diagnostic disable: different-requires, mixed_table, undefined-field

return {
  -- icons
  "echasnovski/mini.icons",
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
      "json",
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
        "json",
        "sass",
        "sh",
        "zsh",
      },
    },
  },
}
