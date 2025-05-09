vim.bo.cindent = true
vim.bo.cinoptions = "(0"
vim.bo.commentstring = "/* %s */"
vim.bo.formatprg = "clang-format"
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4
-- setlocal path+=/usr/include/**,/usr/local/include/**"

if vim.fn.executable("clang-format") then
  vim.bo.formatprg = "clang-format"
end

