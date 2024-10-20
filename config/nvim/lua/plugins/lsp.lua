---@diagnostic disable: different-requires, mixed_table, undefined-field, unused-local

return {
  -- lsp and completion stuff
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = {
      "LspInfo",
      "LspStart",
      "LspStop",
      "LspRestart",
      "LspLog",
    },
    config = function()
      -- Setup lspconfig.
      local lsp_capabilities = {}

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
        vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set(
          "n",
          "<space>wa",
          vim.lsp.buf.add_workspace_folder,
          bufopts
        )
        vim.keymap.set(
          "n",
          "<space>wr",
          vim.lsp.buf.remove_workspace_folder,
          bufopts
        )
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

        require("lspconfig").bashls.setup({
          on_attach = lsp_attach,
        })
        require("lspconfig").vimls.setup({
          on_attach = lsp_attach,
        })
        require("lspconfig").cssls.setup({
          on_attach = lsp_attach,
        })
        require("lspconfig").html.setup({
          on_attach = lsp_attach,
        })
        require("lspconfig").bashls.setup({
          on_attach = lsp_attach,
        })
        require("lspconfig").pyright.setup({
          on_attach = lsp_attach,
        })
        require("lspconfig").ts_ls.setup({
          on_attach = lsp_attach,
        })

        require("lspconfig").clangd.setup({
          on_attach = lsp_attach,

          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
          },
          })

        require("lspconfig").bashls.setup({
          filetypes = { "sh", "zsh" },
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
    end,
  },
  {
    "folke/neodev.nvim",
    ft = "lua",
    config = function()
      require("neodev").setup()
      vim.lsp.start({
        name = "lua-language-server",
        cmd = { "lua-language-server" },
        before_init = require("neodev.lsp").before_init,
        root_dir = vim.fn.getcwd(),
        settings = { Lua = {} },
      })
    end,
  },
}
