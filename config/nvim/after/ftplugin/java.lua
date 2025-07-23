vim.bo.shiftwidth = 2
vim.bo.tabstop = 2

if vim.fn.executable("google-java-format") then
	vim.bo.formatprg = "google-java-format"
end
