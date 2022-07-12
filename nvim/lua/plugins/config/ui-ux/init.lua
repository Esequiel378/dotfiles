local M = {}

M.setup = function(use)
  require("plugins.config.ui-ux.treesitter").setup(use)
  require("plugins.config.ui-ux.colorscheme").setup(use)
  require("plugins.config.ui-ux.startup_screen").setup(use)

  -- TODO: add filetetype event to load only for nginx files
  use { "chr4/nginx.vim" }
  -- ENDOF TODO!

  use { "mechatroner/rainbow_csv" }
  use { "tpope/vim-surround" }
  use { "andymass/vim-matchup" }
  use { "folke/lsp-colors.nvim" }
  use { "shmup/vim-sql-syntax" }
  use { "tribela/vim-transparent" }
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup()
    end,
  }

  use {
    "tpope/vim-commentary",
    keys = { "gc", "gcc", "gbc" },
  }

  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup { default = true }
    end,
  }

  use {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      vim.notify = require "notify"

      require("notify").setup {
        background_colour = "#000000",
      }
    end,
  }
end

return M
