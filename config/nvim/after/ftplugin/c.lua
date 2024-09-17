vim.bo.cindent = true
vim.bo.cinoptions = "(0"
vim.bo.commentstring = "/* %s */"
vim.bo.formatprg = "clang-format"
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4
vim.cmd.setlocal("path+=/usr/include/**,/usr/local/include/**")
vim.opt_local.formatoptions:remove("o")
