---@diagnostic disable: different-requires, mixed_table, undefined-field, unused-local

return {
	-- lsp and completion stuff
	{
		"neovim/nvim-lspconfig",
		event = "FileType",
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
				vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

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

			vim.lsp.config("*", {
				on_attach = lsp_attach,
			})

			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
				},
			})

			vim.lsp.config("bashls", {
				filetypes = { "sh", "zsh" },
			})

			vim.lsp.enable("bashls")
			vim.lsp.enable("clangd")
			vim.lsp.enable("cssls")
			vim.lsp.enable("html")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("pyright")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("vimls")

			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				signs = false,
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		cmd = "LazyDev",
		ft = "lua",
		opts = {
			library = {
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
}
