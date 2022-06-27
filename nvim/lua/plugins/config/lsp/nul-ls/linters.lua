local M = {}

local nls_utils = require("plugins.config.lsp.nul-ls.utils")
local nls_sources = require("null-ls.sources")

local method = require("null-ls").methods.DIAGNOSTICS

M.list_registered = function(filetype)
  local registered_providers = nls_utils.list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

M.list_supported = function(filetype)
  local supported_linters = nls_sources.get_supported(filetype, "diagnostics")
  table.sort(supported_linters)
  return supported_linters
end

return M
