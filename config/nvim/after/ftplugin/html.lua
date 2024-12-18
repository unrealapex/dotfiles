if vim.fn.executable("prettier") then
		vim.bo.formatprg = "prettier --write --stdin-filepath %"
end

