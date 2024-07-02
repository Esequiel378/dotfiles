return {
  {
    'crispgm/nvim-go',
    ft = { 'go', 'gomod' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('go').setup {
        auto_lint = false,
      }
    end,
  },
  {
    'edolphin-ydf/goimpl.nvim',
    ft = { 'go', 'gomod' },
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    keys = {
      {
        '<leader>im',
        function()
          require('telescope').extensions.goimpl.goimpl {}
        end,
        desc = 'Implement Go Interface',
      },
    },
    config = function()
      require('telescope').load_extension 'goimpl'
    end,
  },
  {
    'rafaelsq/nvim-goc.lua',
    event = 'VeryLazy',
    -- stylua: ignore
    keys = {
      { "<leader>gcr", function() require("nvim-goc").Coverage() end,      desc = "Go Coverage", },
      { "<leader>gcc", function() require("nvim-goc").ClearCoverage() end, desc = "Go Clear Coverage", },
      { "<leader>gcf", function() require("nvim-goc").CoverageFunc() end,  desc = "Go Coverage Function", },
      { "<leader>ga", function() require("nvim-goc").Alternate() end,      desc = "Go Coverage", },
    },
    config = function()
      -- if set, when we switch between buffers, it will not split more than once. It will switch to the existing buffer instead
      vim.opt.switchbuf = 'useopen'

      require('nvim-goc').setup {
        verticalSplit = false,
      }
    end,
  },
}
