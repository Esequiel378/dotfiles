return {
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  "tpope/vim-surround",
  "mbbill/undotree",
  {
    "github/copilot.vim",
    config = function()
      local keymap = vim.keymap.set
      keymap("i", "<C-n>", "<Plug>(copilot-next)")
      keymap("i", "<C-p>", "<Plug>(copilot-previous)")
      keymap("i", "<C-e>", "<Plug>(copilot-dismiss)")

      vim.g.copilot_filetypes = { esl = false }
      -- Copilot and cmp can not use <C-y> at the same time - https://github.com/hrsh7th/nvim-cmp/issues/459
      -- keymap("i", "<C-y>", 'copilot#Accept("")')
      -- vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    "tpope/vim-commentary",
    keys = { "gc", "gcc", "gbc" },
  },

  {
    "mechatroner/rainbow_csv",
    ft = "csv",
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = { default = true },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
  },
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = {
      integrations = { diffview = true },
    },
    keys = {
      { "<leader>gs", "<cmd>Neogit<cr>", desc = "Status" },
    },
  },
  {
    "monaqa/dial.nvim",
    event = "BufReadPre",
    config = function()
      vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
      vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
      vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
      vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
    end,
  },
}
