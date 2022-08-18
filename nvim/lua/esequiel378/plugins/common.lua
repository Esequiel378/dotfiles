local M = {}

M.setup = function(use)
  -- extend vim's builtins
  use { "tpope/vim-surround" }
  use { "andymass/vim-matchup" }

  -- colors
  use { "folke/lsp-colors.nvim" }
  use { "mechatroner/rainbow_csv", ft = "csv" }
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup()
    end,
  }

  -- colorscheme
  -- use { "tribela/vim-transparent" }
  use {
    "bluz71/vim-moonfly-colors",
    config = function()
      vim.cmd [[colorscheme moonfly]]
      -- vim.cmd "hi Normal guibg=0000"
    end,
  }

  -- better coments
  use {
    "tpope/vim-commentary",
    keys = { "gc", "gcc", "gbc" },
  }

  -- notification
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

  -- Copilot yay!
  use {
    "github/copilot.vim",
    config = function()
      local map = require("esequiel378.utils").map

      map("i", "<C-y>", 'copilot#Accept("")', { script = true, expr = true })
      map("i", "<C-n>", "<Plug>(copilot-next)")
      map("i", "<C-p>", "<Plug>(copilot-previous)")
      map("i", "<C-e>", "<Plug>(copilot-dismiss)")

      vim.g.copilot_filetypes = { esl = false }
      -- TODO: this is not working, maybe submit a PR/issue
      vim.g.copilot_no_tab_map = true
    end,
  }

  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  }
end

return M
