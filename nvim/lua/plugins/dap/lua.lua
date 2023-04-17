local M = {}

function M.setup()
  local dap = require "dap"
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
      host = "127.0.0.1",
      port = "8086",
    },
  }

  dap.adapters.nlua = function(callback, config)
    callback { type = "server", host = config.host, port = config.port }
  end
end

return M
