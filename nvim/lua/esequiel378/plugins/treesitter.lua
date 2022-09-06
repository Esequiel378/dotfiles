local M = {}

M.setup = function(use)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = M.config,
  }

  use {
    "nvim-treesitter/nvim-treesitter-context",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("treesitter-context").setup {}
    end,
  }
end

M.config = function()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "lua",
      "go",
      "tsx",
      "python",
    },
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
