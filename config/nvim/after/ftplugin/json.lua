if vim.fn.executable("jq") then
	vim.bo.formatprg = "jq"
end
