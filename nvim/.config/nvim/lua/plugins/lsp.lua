require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = {
    'vimls',
    'bashls',
    'pyright',
    'clangd',
    'jdtls',
    'lua_ls',
    'jsonls',
    'sqlls',
    'html',
    'tsserver',
    'cssls',
  }
})


-- Setup lspconfig.
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }

-- lspconfig mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>;', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', '<space>gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wl', function()
  -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set({ 'n', 'x'}, '<space>cf', function()
  vim.lsp.buf.format({ async = true })
  end, bufopts)
end

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = lsp_attach,
      capabilities = lsp_capabilities,
    })
  end,
})


-- disable neovim lsp's inline diagnostics(use lspsaga's popup diagnostics instead)
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)


local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- TODO: move this to its own module

-- lspsaga
require('lspsaga').setup()

-- Show cursor diagnostics automatically in popup window
-- vim.cmd('autocmd CursorHold * silent Lspsaga show_cursor_diagnostics')

-- Lsp finder find the symbol definition implement reference
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })

-- Code action
vim.keymap.set({'n','v'}, '<leader>ca', '<cmd>Lspsaga code_action<CR>')

-- Rename
vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', { silent = true })

-- Rename all occurrences of the hovered word for the selected files
vim.keymap.set('n', '<leader>Rn', '<cmd>Lspsaga rename ++project<CR>')

-- Go to definition
vim.keymap.set('n','gd', '<cmd>Lspsaga goto_definition<CR>')

-- Definition peek
vim.keymap.set('n', 'gD', '<cmd>Lspsaga peek_definition<CR>', { silent = true })

-- Go to type definition
vim.keymap.set('n','gt', '<cmd>Lspsaga goto_type_definition<CR>')

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to 'definition_action_keys'
-- It also supports tagstack
-- Use <C-t> to jump back
vim.keymap.set('n', 'gT', '<cmd>Lspsaga peek_type_definition<CR>')


-- Show line diagnostics
vim.keymap.set('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })

-- Show cursor diagnostic
vim.keymap.set('n', '<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { silent = true })

-- Diagnsotic jump can use `<c-o>` to jump back
vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })

-- Only jump to error
vim.keymap.set('n', '[E', function()
  require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
vim.keymap.set('n', ']E', function()
  require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', { silent = true })

-- Hover Doc
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
vim.keymap.set('n', 'gh', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
-- Floating terminal
vim.keymap.set({'n', 't'}, '<A-d>', '<cmd>Lspsaga term_toggle<CR>')
