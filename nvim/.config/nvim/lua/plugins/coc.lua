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

vim.cmd[[
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
