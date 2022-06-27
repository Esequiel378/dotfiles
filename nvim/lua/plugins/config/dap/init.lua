local M = {}

M.setup = function(use)
  use {
    "mfussenegger/nvim-dap",
    event = "BufReadPre",
    module = { "dap" },
    wants = { "DAPInstall.nvim" },
    requires = {
      -- "nvim-telescope/telescope-dap.nvim",
      { "Pocco81/DAPInstall.nvim", branch = "dev", module = "dap-install" },
      { "leoluz/nvim-dap-go", module = "dap-go" },
      { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    },
    config = M.config,
  }

  use {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dapui.setup {} -- use default
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  }

  use {
    "theHamsta/nvim-dap-virtual-text",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup {
        commented = true,
      }
    end,
  }
end

M.config = function()
  local dap_install = require "dap-install"

  dap_install.setup {
    installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
  }

  local dap_breakpoint = {
    error = {
      text = "??",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "?",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "??",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

  require("plugins.config.dap.lua").setup()
  require("plugins.config.dap.golang").setup()
end

return M
