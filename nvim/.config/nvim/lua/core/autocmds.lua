-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold", "TermClose", "TermLeave" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("auto_read", { clear = true }),
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match

    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- show whitespaces as characters in visual mode
vim.cmd [[
augroup show_whitespace
  autocmd!
  autocmd ModeChanged *:[vV\x16]* :set listchars+=space:·
  autocmd Modechanged [vV\x16]*:* :set listchars-=space:·
augroup END
]]


vim.api.nvim_create_autocmd({ 'BufReadPre', 'FileReadPre' }, {
  group = vim.api.nvim_create_augroup("large_file_detection", { clear = true }),
  callback = function()
    if vim.fn.getfsize(vim.fn.expand('%')) > (512 * 1024) then
      vim.notify(
        'Large file detected, disabling certain features for performance reasons',
        vim.log.levels.WARNING
      )
      if vim.fn.exists(':TSBufDisable') then
        vim.cmd [[TSBufDisable highlight]]
        vim.cmd [[TSBufDisable autotag]]
      end
      vim.opt.foldmethod = 'manual'
      vim.cmd [[syntax clear]]
      vim.cmd [[syntax off]]
      vim.cmd [[filetype off]]
      vim.opt.undofile = false
      vim.opt.swapfile = false
    end
  end
})
