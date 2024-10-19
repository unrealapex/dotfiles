---@diagnostic disable: different-requires, mixed_table, undefined-field

return {
  -- repeat plugin commands
  {
    "tpope/vim-repeat",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },
}
