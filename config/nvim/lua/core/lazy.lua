-- set the mapleader to space
vim.g.mapleader = " "

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
	performance = {
		rtp = {
			disabled_plugins = {
				"tohtml",
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"zipPlugin",
				"rplugin",
				"tutor",
				"osc52",
				"fzf",
			},
		},
	},
})

vim.keymap.set("n", "<leader>l", ":Lazy<CR>")
