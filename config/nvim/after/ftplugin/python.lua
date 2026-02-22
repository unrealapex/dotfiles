if vim.fn.executable("black") then
	vim.bo.formatprg = "black -q 2>/dev/null --stdin-filename % -"
end
