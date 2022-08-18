local M = {}

M.map = function(mode, keys, cmd, opt)
  local options = { noremap = true, silent = true }

  if opt then
    options = vim.tbl_extend("force", options, opt)
  end

  -- all valid modes allowed for mappings
  -- :h map-modes
  local valid_modes = {
    [""] = true,
    ["n"] = true,
    ["v"] = true,
    ["s"] = true,
    ["x"] = true,
    ["o"] = true,
    ["!"] = true,
    ["i"] = true,
    ["l"] = true,
    ["c"] = true,
    ["t"] = true,
  }

  -- helper function for M.map
  -- can gives multiple modes and keys
  local function map_wrapper(imode, lhs, rhs, ioptions)
    if type(lhs) == "table" then
      for _, key in ipairs(lhs) do
        map_wrapper(imode, key, rhs, ioptions)
      end
    else
      if type(imode) == "table" then
        for _, m in ipairs(imode) do
          map_wrapper(m, lhs, rhs, ioptions)
        end
      else
        if valid_modes[imode] and lhs and rhs then
          vim.api.nvim_set_keymap(imode, lhs, rhs, ioptions)
        else
          imode, lhs, rhs = imode or "", lhs or "", rhs or ""
          print("Cannot set mapping [ mode = '" .. imode .. "' | key = '" .. lhs .. "' | cmd = '" .. rhs .. "' ]")
        end
      end
    end
  end

  map_wrapper(mode, keys, cmd, options)
end

function M.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

return M
