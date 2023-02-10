-- keymaps

-- delete previous word in insert mode
vim.keymap.set('i', '<C-BS>', '<C-W>')
-- unindent in insert mode
vim.keymap.set('i', '<S-Tab>', '<C-d>')

-- saner CTRL-L
vim.keymap.set('n', '<C-l>', ':nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>')

-- change directory
vim.keymap.set('n', '<leader>cd', function()
  vim.cmd(':cd ' .. vim.fn.expand("%:p:h"))
  print(vim.fn.getcwd())
end
)

-- vanilla buffer switcher
vim.keymap.set('n', '<leader>b', ':set nomore <Bar> echo "Open buffers:" <Bar> :buffers <Bar> :set more <CR>:b<Space>')


-- TODO: write this in lua
-- find and replace on current selection
-- snippet written by Bryan Kennedy and Peter Butkovic
-- https://stackoverflow.com/a/6171215/14111707
vim.cmd [[
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vnoremap <C-r> <Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>
]]

-- buffer stuff
-- create a new buffer
vim.keymap.set('n', '<leader>n', ':enew<CR>')
-- delete a buffer
vim.keymap.set('n', '<leader>q', ':bd<CR>')

-- switch tabs quickly
vim.keymap.set('n', '<leader>1', '1gt<CR>')
vim.keymap.set('n', '<leader>2', '2gt<CR>')
vim.keymap.set('n', '<leader>3', '3gt<CR>')
vim.keymap.set('n', '<leader>4', '4gt<CR>')
vim.keymap.set('n', '<leader>5', '5gt<CR>')
vim.keymap.set('n', '<leader>6', '6gt<CR>')
vim.keymap.set('n', '<leader>7', '7gt<CR>')
vim.keymap.set('n', '<leader>8', '8gt<CR>')
vim.keymap.set('n', '<leader>9', '9gt<CR>')
-- open a tab
vim.keymap.set('n', '<Leader>t', ':tabnew<CR>')
-- close a tab
vim.keymap.set('n', '<Leader>x', ':tabclose<CR>')

-- Resize splits with ctrl + arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- easier copying and pasteing into clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')

-- don't lose selection when shifting text
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

-- plugin related keymaps
-- lazy loaded plugin keymaps set here
-- NOTE: ensure that keymaps for plugins lazy loaded by command are here or
-- else they won't load

-- telescope keymaps
vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files()
end
)
vim.keymap.set('n', '<leader>fg', function()
  require('telescope.builtin').live_grep()
end
)


-- coc keymaps
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

-- Make <Tab> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
vim.keymap.set("i", "<Tab>", [[coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"]], opts)

-- Use <c-space> to trigger completion.
vim.keymap.set("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- GoTo code navigation.
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.keymap.set("n", "<leader>gi", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })


-- Use K to show documentation in preview window.
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })
vim.keymap.set("n", "gh", '<CMD>lua _G.show_docs()<CR>', { silent = true })


-- Symbol renaming.
vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })


-- format whole file
vim.keymap.set("n", "<leader>cf", "<Plug>(coc-format)", { silent = true })
-- format selected code
vim.keymap.set("x", "<leader>cf", "<Plug>(coc-format-selected)", { silent = true })

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
local opts = { silent = true, nowait = true }

-- Remap keys for applying codeAction to the current buffer.
vim.keymap.set("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)

-- Apply AutoFix to problem on the current line.
vim.keymap.set("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Run the Code Lens action on the current line.
vim.keymap.set("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
vim.keymap.set({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)", opts)
vim.keymap.set({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)", opts)
vim.keymap.set({ "x", "o" }, "ic", "<Plug>(coc-classobj-i)", opts)
vim.keymap.set({ "x", "o" }, "ac", "<Plug>(coc-classobj-a)", opts)

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
vim.keymap.set({ "n", "x" }, "<C-s>", "<Plug>(coc-range-select)", { silent = true })


-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
-- Show all diagnostics.
vim.keymap.set("n", "<leader>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions.
-- vim.keymap.set("n", "<leader>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands.
-- vim.keymap.set("n", "<leader>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document.
vim.keymap.set("n", "<leader>co", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols.
vim.keymap.set("n", "<leader>cs", ":<C-u>CocList -I symbols<cr>", opts)

-- restart coc if needed
vim.keymap.set('n', '<leader>cr', ':<C-u>CocRestart<CR>', { silent = true })

-- scroll through coc hover doc
vim.cmd [[
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
]]

vim.keymap.set('n', '[d', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.keymap.set('n', ']d', '<Plug>(coc-diagnostic-next)', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<Plug>(coc-codeaction-selected)<CR>')

vim.keymap.set('n', '<leader>ce', ':CocList extensions<CR>')

vim.keymap.set('n', '<leader>z', function()
  require("zen-mode").toggle({
    window = {
      width = 0.85 -- width will be 85% of the editor width
    }
  })
end)

