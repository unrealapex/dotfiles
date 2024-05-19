---@diagnostic disable: different-requires, mixed_table, undefined-field

return {
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
}
