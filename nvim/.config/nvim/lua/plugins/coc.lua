vim.g.coc_global_extensions = {
  'coc-vimlsp',
  'coc-sumneko-lua',
  'coc-sh',
  'coc-pyright',
  'coc-clangd',
  'coc-java',
  'coc-sql',
  'coc-html',
  'coc-html-css-support',
  'coc-tsserver',
  'coc-css',
  'coc-json',
  'coc-highlight',
  'coc-snippets',
  'coc-lightbulb',
  'coc-calc',
  'coc-emoji',
}

-- Autocomplete
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

vim.cmd [[
  autocmd CursorHold * silent call CocActionAsync('highlight')
]]

vim.api.nvim_create_augroup("CocGroup", {})

-- Setup formatexpr specified filetype(s).
vim.api.nvim_create_autocmd("FileType", {
  group = "CocGroup",
  pattern = "typescript,json",
  command = "setl formatexpr=CocAction('formatSelected')",
  desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder.
vim.api.nvim_create_autocmd("User", {
  group = "CocGroup",
  pattern = "CocJumpPlaceholder",
  command = "call CocActionAsync('showSignatureHelp')",
  desc = "Update signature help on jump placeholder"
})

-- Add `:Format` command to format current buffer.
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer.
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

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
