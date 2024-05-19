---@diagnostic disable: different-requires, mixed_table, undefined-field

return {
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
}
