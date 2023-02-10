-- Gitsigns mappings

require('gitsigns').setup({
  signs = {
    add = {
      hl = "GitSignsAdd",
      text = "▎",
      numhl = "GitSignsAddNr",
      linehl = "GitSignsAddLn"
    },
    change = {
      hl = "GitSignsChange",
      text = "▎",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn"
    },
    delete = {
      hl = "GitSignsDelete",
      text = "契",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn"
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "契",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn"
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "▎",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn"
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
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() package.loaded.gitsigns.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() package.loaded.gitsigns.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- stage hunk
    vim.keymap.set({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    -- reset hunk
    vim.keymap.set({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    -- stage buffer
    vim.keymap.set('n', '<leader>hS', package.loaded.gitsigns.stage_buffer)
    -- undo stage hunk
    vim.keymap.set('n', '<leader>hu', package.loaded.gitsigns.undo_stage_hunk)
    -- reset buffer
    vim.keymap.set('n', '<leader>hR', package.loaded.gitsigns.reset_buffer)
    -- preview
    vim.keymap.set('n', '<leader>hp', package.loaded.gitsigns.preview_hunk)
    -- line blame
    vim.keymap.set('n', '<leader>hb', function() package.loaded.gitsigns.blame_line { full = true } end)
    -- current line blame
    vim.keymap.set('n', '<leader>tb', package.loaded.gitsigns.toggle_current_line_blame)
    -- diff
    vim.keymap.set('n', '<leader>hd', package.loaded.gitsigns.diffthis)
    vim.keymap.set('n', '<leader>hD', function() package.loaded.gitsigns.diffthis('~') end)
    -- show deleted lines
    vim.keymap.set('n', '<leader>td', package.loaded.gitsigns.toggle_deleted)

    -- in hunk text object
    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
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
    enable = false
  },

})
