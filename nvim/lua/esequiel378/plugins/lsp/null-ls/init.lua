local nls = require "null-ls"
local nls_utils = require "null-ls.utils"

local M = {}

local b = nls.builtins

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

local sources = {
  -- formatting
  b.formatting.prettier,
  b.formatting.nginx_beautifier,
  b.formatting.shfmt,
  b.formatting.fixjson.with { extra_args = { "-i", "2" } },
  b.formatting.black.with { extra_args = { "--fast" } },
  b.formatting.isort,
  b.formatting.sql_formatter.with {
    extra_args = {
      "--config",
      vim.fn.expand "~/.config/nvim/lua/esequiel378/plugins/lsp/null-ls/config/sql-formatter.json",
    },
  },
  with_root_file(b.formatting.stylua, "stylua.toml"),

  -- diagnostics
  b.diagnostics.write_good,
  b.diagnostics.misspell,
  b.diagnostics.eslint_d,
  b.diagnostics.tsc,
  -- b.diagnostics.flake8,
  b.diagnostics.pyproject_flake8,

  with_root_file(b.diagnostics.selene, "selene.toml"),
  with_diagnostics_code(b.diagnostics.shellcheck),

  -- code actions
  b.code_actions.eslint_d,
  b.code_actions.proselint,

  -- hover
  b.hover.dictionary,
}

M.setup = function(options)
  local map = require("esequiel378.utils").map

  map("n", "<leader>fm", ":lua vim.lsp.buf.formatting_sync() <CR>")
  map("v", "<leader>fm", ":lua vim.lsp.buf.range_formatting() <CR>")

  nls.setup {
    debounce = 150,
    save_after_format = false,
    sources = sources,
    on_attach = options.on_attach,
    root_dir = nls_utils.root_pattern ".git",
  }
end

return M
