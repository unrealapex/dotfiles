if vim.fn.executable("prettier") then
		vim.bo.formatprg = "prettier --stdin-filepath %"
end

