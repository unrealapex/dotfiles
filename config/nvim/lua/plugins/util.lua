---@diagnostic disable: different-requires, mixed_table, undefined-field

return {
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

  -- repeat plugin commands
  {
    "tpope/vim-repeat",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },
}
