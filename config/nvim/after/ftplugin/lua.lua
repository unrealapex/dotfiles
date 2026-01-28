vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2

if vim.fn.executable("stylua") then
	vim.bo.formatprg = "stylua -"
end
