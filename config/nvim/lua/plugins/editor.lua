---@diagnostic disable: different-requires, mixed_table, undefined-field

return {
	-- better git integration
	{
		"lewis6991/gitsigns.nvim",
		cond = vim.fn.executable("git") == 1,
		-- NOTE: loading this plugin is faster than checking if current buffer is
		-- under version control so just load on buffer events
		event = "FileType",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = {
						text = "+",
					},
					change = {
						text = "~",
					},
					delete = {
						text = "-",
					},
					topdelete = {
						text = "-",
					},
					changedelete = {
						text = "-",
					},
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")
					-- hunk navigation
					vim.keymap.set("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					vim.keymap.set("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Actions
					vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk)
					vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
					vim.keymap.set("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					vim.keymap.set("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer)
					vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk)
					vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer)
					vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)
					vim.keymap.set("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end)
					vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame)
					vim.keymap.set("n", "<leader>hd", gitsigns.diffthis)
					vim.keymap.set("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end)
					vim.keymap.set("n", "<leader>td", gitsigns.toggle_deleted)

					-- Text object
					vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
					delay = 1000,
					ignore_whitespace = false,
				},
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000,
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		config = true,
		keys = {
			{ "<leader>o", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
		},
	},
}
