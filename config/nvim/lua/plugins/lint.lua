require("lint").linters_by_ft = {
  c = { "cpplint" },
  cpp = { "cpplint" },
  javascript = { "eslint_d" },
  lua = { "selene" },
  luau = { "selene" },
  markdown = { "vale" },
  python = { "flake" },
  sh = { "shellcheck" },
  typescript = { "eslint_d" },
  vimscript = { "vint" },
  zsh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
