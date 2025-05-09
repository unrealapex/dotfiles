---@diagnostic disable: deprecated, lowercase-global
-- keymaps

-- change directory
vim.keymap.set("n", "<leader>cd", function()
  vim.cmd.cd(vim.fn.expand("%:p:h"))
  vim.notify(vim.fn.getcwd())
end)

-- vanilla buffer switcher
-- vim.keymap.set('n', '<leader><leader>', ':set nomore <Bar> echo "Open buffers:" <Bar> :buffers <Bar> :set more <CR>:b<Space>')

-- find and replace on current selection
-- written in lua
-- vimscript solution: https://stackoverflow.com/a/6171215/14111707

-- get contents of visual selection
-- handle unpack deprecation
table.unpack = table.unpack or unpack
function get_visual()
  local _, ls, cs = table.unpack(vim.fn.getpos("v"))
  local _, le, ce = table.unpack(vim.fn.getpos("."))
  return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
end

-- buffer stuff
-- create a new buffer
vim.keymap.set("n", "<leader>n", ":enew<CR>")

-- switch tabs quickly
vim.keymap.set("n", "<leader>1", "1gt<CR>")
vim.keymap.set("n", "<leader>2", "2gt<CR>")
vim.keymap.set("n", "<leader>3", "3gt<CR>")
vim.keymap.set("n", "<leader>4", "4gt<CR>")
vim.keymap.set("n", "<leader>5", "5gt<CR>")
vim.keymap.set("n", "<leader>6", "6gt<CR>")
vim.keymap.set("n", "<leader>7", "7gt<CR>")
vim.keymap.set("n", "<leader>8", "8gt<CR>")
vim.keymap.set("n", "<leader>9", "9gt<CR>")

-- open a tab
vim.keymap.set("n", "<leader>t", ":tabnew<CR>")
-- close a tab
vim.keymap.set("n", "<leader>x", ":tabclose<CR>")

-- Resize splits with ctrl + arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- don't lose selection when shifting text
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")
