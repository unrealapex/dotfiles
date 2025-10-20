vim.bo.expandtab = false

if vim.fn.executable("shfmt") then
	vim.bo.formatprg = "shfmt"
end
