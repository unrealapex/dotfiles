---@diagnostic disable: different-requires, mixed_table, undefined-field

return {
  -- debugging
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
      },
      {
        "<F1>",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<F2>",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<F3>",
        function()
          require("dap").step_out()
        end,
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
      },
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
      },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
      },
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
      },
      {
        "<leader>ds",
        function()
          require("dap.ui.widgets").scopes()
        end,
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
      },
      {
        "<leader>dq",
        function()
          require("dap").terminate()
        end,
      },
      -- dap ui keymaps
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
      },
      {
        "<leader>de",
        mode = { "n", "v" },
        function()
          require("dapui").eval()
        end,
      },
      {
        "<leader>dE",
        function()
          require("dapui").eval(vim.fn.input("[Expression] > "))
        end,
      },
    },
    cmd = {
      "DapInstall",
      "DapShowLog",
      "DapStepOut",
      "DapContinue",
      "DapStepInto",
      "DapStepOver",
      "DapTerminate",
      "DapUninstall",
      "DapToggleRepl",
      "DapSetLogLevel",
      "DapRestartFrame",
      "DapLoadLaunchJSON",
      "DapToggleBreakpoint",
    },
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "williamboman/mason.nvim",
        opts = {
          automatic_installation = true,
        },
      },
      {
        "rcarriga/nvim-dap-ui",
        dependencies = "nvim-neotest/nvim-nio",
      },
      -- TODO: add more debug adapters
      {
        "jbyuki/one-small-step-for-vimkind",
      },
      {
        "mfussenegger/nvim-dap-python",
      },
    },
    config = function()
      ---@diagnostic disable-next-line: different-requires
      local dap = require("dap")
      local dapui = require("dapui")

      ---@diagnostic disable-next-line: missing-fields
      require("mason-nvim-dap").setup({
        automatic_setup = true,
        handlers = {},
        ensure_installed = {
          "bash-debug-adapter",
          "java-debug-adapter",
          "firefox-debug-adapter",
          "debugpy",
          "cpptools",
        },
      })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      -- TODO: test this setup/possibly modify
      ---@diagnostic disable-next-line: missing-fields
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

      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })
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

      dap.adapters.nlua = function(callback, conf)
        local adapter = {
          type = "server",
          host = conf.host or "127.0.0.1",
          port = conf.port or 8086,
        }
        if conf.start_neovim then
          local dap_run = dap.run
          dap.run = function(c)
            adapter.port = c.port
            adapter.host = c.host
          end
          require("osv").run_this()
          dap.run = dap_run
        end
        callback(adapter)
      end
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Run this file",
          start_neovim = {},
        },
        {
          -- TODO: this doesn't work for some reason
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance (port = 8086)",
          port = 8086,
        },
      }

      dap.adapters.bashdb = {
        type = "executable",
        command = vim.fn.stdpath("data")
          .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
        name = "bashdb",
      }
      dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data")
          .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data")
          .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }

      dap.adapters.java = function(callback)
        -- FIXME:
        -- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
        -- The response to the command must be the `port` used below
        callback({
          type = "server",
          host = "127.0.0.1",
          port = port,
        })
      end

      dap.adapters.firefox = {
        type = "executable",
        command = "node",
        args = {
          os.getenv("HOME")
            .. "/mason/packages/vscode-firefox-debug/dist/adapter.bundle.js",
        },
      }

      dap.configurations.typescript = {
        {
          name = "Debug with Firefox",
          type = "firefox",
          request = "launch",
          reAttach = true,
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          firefoxExecutable = "/usr/bin/firefox",
        },
      }
    end,
  },
}
