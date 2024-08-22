-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- load lazy
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  change_detection = {
    notify = false,
  },
  ui = {
    icons = {
      cmd = "[cmd]",
      config = "[config]",
      event = "[event]",
      ft = "[ft]",
      init = "[init]",
      keys = "[keys]",
      plugin = "[plugin]",
      runtime = "[runtime]",
      require = "[require]",
      source = "[source]",
      start = "[start]",
      task = "[task]",
      -- lazy = "[lazy]",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "tar",
        "tarPlugin",
        "rrhelper",
        "zip",
        "zipPlugin",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "bugreport",
        "ftplugin",
        "tutor",
      },
    },
  },
  install = {
    colorscheme = { vim.g.colors_name, "default" },
  },
})

vim.keymap.set("n", "<leader>l", ":Lazy<CR>")
