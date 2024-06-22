---@diagnostic disable: different-requires, mixed_table, undefined-field

return {
  -- better file explorer
  {
    "justinmk/vim-dirvish",
    keys = "-",
    cmd = "Dirvish",
    init = function()
      -- check if a file argument supplied is a directory
      local argv_contains_dir = false
      ---@diagnostic disable-next-line: unused-local
      for k, v in pairs(vim.fn.argv()) do
        if vim.fn.isdirectory(v) == 1 then
          argv_contains_dir = true
        end
      end
      if vim.fn.argc() >= 1 and argv_contains_dir then
        require("lazy").load({ plugins = { "vim-dirvish" } })
      end
      -- load dirvish when a directory is opened
      vim.api.nvim_create_autocmd("BufNew", {
        callback = function()
          if require("lazy.core.config").plugins["vim-dirvish"]._.loaded then
            return true
          end

          if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
            require("lazy").load({ plugins = { "vim-dirvish" } })
            return true
          end
        end,
      })
    end,
    dependencies = "bounceme/remote-viewer",
  },
  -- unix helpers
  {
    "tpope/vim-eunuch",
    cmd = {
      "Remove",
      "Unlink",
      "Delete",
      "Copy",
      "Duplicate",
      "Move",
      "Rename",
      "Chmod",
      "Mkdir",
      "Cfind",
      "Lfind",
      "Clocate",
      "Llocate",
      "SudoEdit",
      "SudoWrite",
      "Wall",
      "W",
    },
  },
  -- rsi style mappings
  {
    "tpope/vim-rsi",
    keys = {
      { "<C-a>", mode = { "c", "i" } },
      { "<C-x><C-a>", mode = { "c", "i" } },
      { "<C-b>", mode = { "c", "i" } },
      { "<C-d>", mode = { "c", "i" } },
      { "<C-e>", mode = { "c", "i" } },
      { "<C-f>", mode = { "c", "i" } },
      { "<C-g>", mode = { "c", "i" } },
      { "<C-t>", mode = { "c", "i" } },
      { "<M-BS>", mode = { "c", "i" } },
      { "<M-b>", mode = { "c", "i" } },
      { "<M-d>", mode = { "c", "i" } },
      { "<M-f>", mode = { "c", "i" } },
      { "<M-n>", mode = { "c", "i" } },
      { "<C-p>", mode = { "c", "i" } },
    },
  },

  -- fuzzy finder
  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
      },
      {
        "<leader>fg",
        function()
          require("fzf-lua").live_grep()
        end,
      },
      {
        "<leader><leader>",
        function()
          require("fzf-lua").buffers()
        end,
      },
      {
        "<leader>fh",
        function()
          require("fzf-lua").help_tags()
        end,
      },
      {
        "<leader>fd",
        function()
          require("fzf-lua").diagnostics_document()
        end,
      },
      {
        "<leader>fo",
        function()
          require("fzf-lua").oldfiles()
        end,
      },
      {
        "<leader>fs",
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
      },
    },
    cmd = { "FzfLua" },
    cond = vim.fn.executable("fzf") == 1,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      previewers = {
        builtin = {
          extensions = {
            -- neovim terminal only supports `viu` block output
            ["gif"] = { "chafa" },
            ["jpg"] = { "chafa" },
            ["png"] = { "chafa" },
            ["webp"] = { "chafa" },
          },
        },
      },
    },
  },

  -- better git integration
  {
    "lewis6991/gitsigns.nvim",
    cond = vim.fn.executable("git") == 1,
    -- NOTE: loading this plugin is faster than checking if current buffer is
    -- under version control so just load on buffer events
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      -- Gitsigns mappings

      require("gitsigns").setup({
        signs = {
          add = {
            text = "▎",
          },
          change = {
            text = "▎",
          },
          delete = {
            text = "󰐊",
          },
          topdelete = {
            text = "󰐊",
          },
          changedelete = {
            text = "▎",
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
          -- hunk navigation
          vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              package.loaded.gitsigns.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              package.loaded.gitsigns.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- stage hunk
          vim.keymap.set({ "n", "v" }, "<leader>hs", function()
            package.loaded.gitsigns.stage_buffer()
            vim.notify("staged hunk")
          end)
          -- reset hunk
          vim.keymap.set({ "n", "v" }, "<leader>hr", function()
            package.loaded.gitsigns.reset_hunk()
            vim.notify("reset hunk")
          end)
          -- stage buffer
          vim.keymap.set("n", "<leader>hS", function()
            package.loaded.gitsigns.stage_buffer()
            vim.notify("staged buffer")
          end)
          -- undo stage hunk
          vim.keymap.set("n", "<leader>hu", function()
            package.loaded.gitsigns.undo_stage_hunk()
            vim.notify("undid stage hunk")
          end)
          -- reset buffer
          vim.keymap.set("n", "<leader>hR", function()
            package.loaded.gitsigns.reset_buffer()
            vim.notify("reset buffer")
          end)
          -- preview
          vim.keymap.set("n", "<leader>hp", function()
            package.loaded.gitsigns.preview_hunk()
            vim.notify("preview hunk")
          end)
          -- line blame
          vim.keymap.set("n", "<leader>hb", function()
            package.loaded.gitsigns.blame_line({ full = true })
          end)
          -- current line blame
          vim.keymap.set(
            "n",
            "<leader>tb",
            package.loaded.gitsigns.toggle_current_line_blame
          )
          -- diff
          vim.keymap.set("n", "<leader>hd", package.loaded.gitsigns.diffthis)
          vim.keymap.set("n", "<leader>hD", function()
            package.loaded.gitsigns.diffthis("~")
          end)
          -- show deleted lines
          vim.keymap.set(
            "n",
            "<leader>td",
            package.loaded.gitsigns.toggle_deleted
          )

          -- in hunk text object
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
        current_line_blame_formatter_opts = {
          relative_time = false,
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
        yadm = {
          enable = false,
        },
      })
    end,

  },

  -- git commit browser
  {
    "sindrets/diffview.nvim",
    cond = vim.fn.executable("git") == 1 or vim.fn.executable("mercurial") == 1,
    cmd = {
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewLog",
      "DiffviewOpen",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
}
