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
				"osc52",
				"fzf",
				"man",
			},
		},
	},
	install = {
		colorscheme = { "vim" },
	},
})

vim.keymap.set("n", "<leader>l", ":Lazy<CR>")
