vim.bo.expandtab = false


if vim.fn.executable("shfmt") then
	vim.bo.formatprg = "shfmt --indent 2"
end
