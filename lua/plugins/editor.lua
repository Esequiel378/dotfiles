return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = {
      { "gc", mode = { "n", "v" } },
      { "gcc", mode = { "n", "v" } },
      { "gbc", mode = { "n", "v" } },
    },
    config = function(_, _)
      local opts = {
        ignore = "^$",
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
      require("Comment").setup(opts)
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd.colorscheme("tokyonight-night")
      vim.cmd.hi("Comment gui=none")
    end,
  },
  {
    "andymass/vim-matchup",
    lazy = false,
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    cmd = "Copilot",
    keys = {
      { "<C-n>", mode = { "i" }, "<Plug>(copilot-next)", desc = "Next Copilot suggestion" },
      { "<C-p>", mode = { "i" }, "<Plug>(copilot-previous)", desc = "Previous Copilot suggestion" },
      { "<C-e>", mode = { "i" }, "<Plug>(copilot-dismiss)", desc = "Dismiss Copilot suggestion" },
    },
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Remove trailing spaces from lines
      require('mini.trailspace').setup()

      -- Set up autocmd to trim trailing spaces and last lines on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          require('mini.trailspace').trim()         -- Trim trailing whitespace
          require('mini.trailspace').trim_last_lines() -- Trim trailing empty lines
        end,
      })

      -- Simple and easy statusline
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "nvim-telescope/telescope.nvim" },
    },
    lazy = false,
    branch = "regexp",
    config = function()
      require("venv-selector").setup({
        stay_on_this_version = true,
      })
    end,
    keys = {
			-- Keymap to open VenvSelector to pick a venv.
			{ "<leader>vs", "<cmd>VenvSelect<cr>" },
			-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
			{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },
}
