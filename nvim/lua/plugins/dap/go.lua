local M = {}

function M.setup()
  local dap = require "dap"
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      showLog = true,
      program = "${file}",
      -- console = "externalTerminal",
      dlvToolPath = vim.fn.exepath "dlv",
    },
    {
      name = "Test Current File",
      type = "go",
      request = "launch",
      showLog = true,
      mode = "test",
      program = ".",
      dlvToolPath = vim.fn.exepath "dlv",
    },
  }
  dap.adapters.nlua = function(callback, config)
    callback { type = "server", host = config.host, port = config.port }
  end

  require("dap-go").setup {}
end

return M
