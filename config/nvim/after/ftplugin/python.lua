if vim.fn.executable("black") then
	vim.bo.formatprg = "black -q - < %"
end
