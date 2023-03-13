-- treesitter stuff
local configs = require("nvim-treesitter.configs")
configs.setup {
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "diff",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "git_rebase",
    "help",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "r",
    "regex",
    "sql",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  auto_install = true,
  highlight = {
    enable = true,                    -- false will disable the whole extension
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end
  },
  indent = { enable = true, disable = { "yaml" } },
}
-- hack to make rainbow_parentheses work with treesitter
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "" })