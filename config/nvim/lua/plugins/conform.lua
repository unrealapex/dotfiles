require("conform").setup({
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
})
