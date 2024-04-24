---@diagnostic disable: unused-local
require("mason").setup({
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
    border = "rounded",
  },
})

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
    "vimls",
  },
})

-- FIXME: ensure these formatters are installed
--  black
--  clang-format
--  google-java-format
--  isort
--  jq
--  prettier
--  prettierd
--  shfmt
--  stylua

-- Setup lspconfig.
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require("lspconfig")["<YOUR_LSP_SERVER>"].setup {
--   capabilities = capabilities
-- }

-- lspconfig mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- redundtant with inline diagnostics but keeping anyways
vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ float = false })
end, opts)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({ float = false })
end, opts)
vim.keymap.set("n", "<space>;", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set({ "n", "v" }, "<space>ca", function()
    vim.lsp.buf.code_action({
      context = { only = { "quickfix", "refactor", "source" } },
    })
  end, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
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

require("mason-lspconfig").setup_handlers({
  lspconfig["clangd"].setup({
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,

    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  }),
})

-- diagnostic text highlight is given to the line number
for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
  vim.fn.sign_define("DiagnosticSign" .. diag, {
    text = "",
    texthl = "DiagnosticSign" .. diag,
    linehl = "",
    numhl = "DiagnosticSign" .. diag,
  })
end

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
})

-- NOTE: maybe disable gutter signs entirely
-- vim.diagnostic.config({signs = false})
