-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd(
  { "FocusGained", "CursorHold", "TermClose", "TermLeave" },
  {
    pattern = "*",
    group = vim.api.nvim_create_augroup("auto_read", { clear = true }),
    callback = function()
      if vim.fn.getcmdwintype() == "" then
        vim.cmd.checktime()
      end
    end,
  }
)

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
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

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n",
      "q",
      "<cmd>close<cr>",
      { buffer = event.buf, silent = true }
    )
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  -- pattern = { "gitcommit", "markdown" },
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- adjust indent guide spacing for files with a shiftwidth that isn't two
vim.api.nvim_create_autocmd("OptionSet", {
  group = vim.api.nvim_create_augroup(
    "indent_guide_shiftwidth",
    { clear = true }
  ),
  pattern = { "listchars", "tabstop", "filetype" },
  callback = function()
    if not vim.opt_local.shiftwidth:get() == 2 then
      local lead = "│"
      for _ = 1, vim.bo.shiftwidth - 1 do
        lead = lead .. " "
      end
      vim.opt_local.listchars:append({ leadmultispace = lead })
    end
  end,
})

-- render whitespace in visual mode
local show_whitespace_group =
  vim.api.nvim_create_augroup("show_whitespace", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
  group = show_whitespace_group,
  pattern = { "*:[vV\x16]*" },
  callback = function()
    vim.opt.listchars:append({ space = "·" })
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  group = show_whitespace_group,
  pattern = { "[vV\x16]*:*" },
  callback = function()
    vim.opt.listchars:remove({ "space" })
  end,
})
