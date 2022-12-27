local M = {}

M.setup = function(use)
  use {
    "williamboman/mason.nvim",
    config = M.config,
    requires = {
      {
        "folke/neodev.nvim",
        config = function()
          -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
          require("neodev").setup {}
        end,
      },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "b0o/schemastore.nvim",
      "folke/neodev.nvim",
      "neovim/nvim-lspconfig",
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "jose-elias-alvarez/typescript.nvim",
    },
  }

  use {
    "SmiteshP/nvim-navic",
    module = { "nvim-navic" },
    requires = { "neovim/nvim-lspconfig" },
    config = function()
      require("nvim-navic").setup {}
    end,
  }

  use {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
  }

  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup {}
      local map = require("esequiel378.utils").map

      map("n", "<leader>s", "<cmd>SymbolsOutline<cr>")
    end,
  }
end

M.config = function()
  require("esequiel378.plugins.lsp.installer").config()
  require("esequiel378.plugins.lsp.handlers").config()
end

return M
