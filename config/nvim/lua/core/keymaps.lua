---@diagnostic disable: deprecated, lowercase-global
-- keymaps

-- delete previous word in insert mode
vim.keymap.set("i", "<C-BS>", "<C-W>")
-- unindent in insert mode
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- change directory
vim.keymap.set("n", "<leader>cd", function()
  vim.cmd.cd(vim.fn.expand("%:p:h"))
  vim.notify(vim.fn.getcwd())
end)

-- lua implementation of neovim's <C-L> bind that also clears vim-notify notifications
vim.keymap.set("n", "<C-l>", function()
  vim.cmd.nohlsearch()
  vim.cmd.diffupdate()
  vim.cmd.mode()
  vim.cmd.redraw()
end)
-- vanilla buffer switcher
-- vim.keymap.set('n', '<leader>b', ':set nomore <Bar> echo "Open buffers:" <Bar> :buffers <Bar> :set more <CR>:b<Space>')

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

vim.keymap.set("v", "<C-r>", function()
  local pattern = table.concat(get_visual())
  -- escape regex and line endings
  pattern =
    vim.fn.substitute(vim.fn.escape(pattern, "^$.*\\/~[]"), "\n", "\\n", "g")
  -- send substitute command to vim command line
  vim.api.nvim_input("<Esc>:%s/" .. pattern .. "//g<Left><Left>")
end)

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

-- lua implementation of gx
-- original gx map does not work without netrw, see :help netrw-gx
-- i have netrw disabled because i use vim-dirvish as my file explorer instead
-- unfortunately as a result some functionality that is dependant on it does
-- not function
vim.keymap.set("n", "gx", function()
  vim.fn.jobstart("xdg-open " .. vim.fn.expand("<cfile>"), { detach = true })
end)
