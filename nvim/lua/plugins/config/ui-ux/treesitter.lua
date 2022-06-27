local M = {}

M.setup = function(use)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = M.config,
  }
end

M.config = function()
  require("nvim-treesitter.configs").setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      "lua",
      "go",
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    autopairs = {
      enable = true,
    },
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
    },
    context_commentstring = {
      enable = true,
    },
    endwise = {
      enable = true,
    },
  }
end

return M
