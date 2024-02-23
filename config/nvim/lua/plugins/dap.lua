local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup({
  automatic_setup = true,
  handlers = {},
  ensure_installed = {
    "bash-debug-adapter",
    "java-debug-adapter",
    "debugpy",
    "codelldb",
  },
})

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
-- TODO: test this setup/possibly modify
dapui.setup({
  active = true,
  on_config_done = nil,
  breakpoint = {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  breakpoint_rejected = {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "",
    texthl = "DiagnosticSignWarn",
    linehl = "Visual",
    numhl = "DiagnosticSignWarn",
  },
  log = {
    level = "info",
  },
  ui = {
    auto_open = true,
    notify = {
      threshold = vim.log.levels.INFO,
    },
    config = {
      icons = { expanded = "", collapsed = "", circular = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      -- Use this to override mappings for specific elements
      element_mappings = {},
      expand_lines = true,
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            { id = "repl", size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      },
      controls = {
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5, -- Floats will be treated as percentage of your screen.
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    },
  },
})

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapStopped",
  { text = "", texthl = "WarningMsg", linehl = "", numhl = "" }
)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Install golang specific config
-- require('dap-go').setup()

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
  },
}

dap.adapters.nlua = function(callback, config)
  callback({
    type = "server",
    host = config.host or "127.0.0.1",
    port = config.port or 8086,
  })
end
