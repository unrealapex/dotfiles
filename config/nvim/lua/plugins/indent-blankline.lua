require("ibl").setup({
  scope = {
    enabled = true,
    show_start = true
  },
  exclude = {
    filetypes = {
      "''",
      "TelescopePrompt",
      "TelescopeResults",
      "checkhealth",
      "gitcommit",
      "help",
      "lspinfo",
      "man",
      "packer",
      "NvimTree",
      "Trouble",
      "WhichKey",
      "dashboard",
      "help",
      "lsp-installer",
      "mason",
      "neogitstatus",
      "packer",
      "sh",
      "startify",
      "text",
    }
  }
})