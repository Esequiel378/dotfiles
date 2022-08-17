local M = {}

local sources = require "null-ls.sources"
local disgnostics_method = require("null-ls").methods.DIAGNOSTICS

M.list_registered_providers_names = function(filetype)
  local available_sources = sources.get_available(filetype)
  local registered = {}

  for _, source in ipairs(available_sources) do
		for method in pairs(source.methods) do
			registered[method] = registered[method] or {}
			table.insert(registered[method], source.name)
		end
  end

  return registered
end

M.list_registered = function(filetype)
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[disgnostics_method] or {}
end

M.list_supported = function(filetype)
  local supported_linters = sources.get_supported(filetype, "diagnostics")
  table.sort(supported_linters)
  return supported_linters
end

return M
