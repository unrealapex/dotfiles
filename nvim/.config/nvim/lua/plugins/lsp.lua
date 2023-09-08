require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "clangd",
    "cssls",
    "html",
    "jdtls",
    "jsonls",
    "lua_ls",
    "pyright",
    "sqlls",
    "tsserver",
    "vimls"
  }
})


-- Setup lspconfig.
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require("lspconfig")["<YOUR_LSP_SERVER>"].setup {
--   capabilities = capabilities
-- }

-- lspconfig mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<space>;", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set("n", "<space>gi", vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wl", function()
  -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set({ "n", "x" }, "<space>cf", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = lsp_attach,
      capabilities = lsp_capabilities,
    })
  end,
})


-- disable neovim lsp"s inline diagnostics and use lspsaga"s diagnostics ui instead
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)


local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
