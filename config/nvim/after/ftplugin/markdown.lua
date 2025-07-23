vim.bo.expandtab = true

if vim.fn.executable("prettier") then
	vim.bo.formatprg = "prettier --write --prose-wrap always --stdin-filepath %"
end
