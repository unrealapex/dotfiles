vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2

if vim.fn.executable("shfmt") then
  vim.bo.formatprg = "shfmt --indent 2"
end
