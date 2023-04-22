return {
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  { "tpope/vim-surround", event = "VeryLazy" },
  "mbbill/undotree",
  {
    "github/copilot.vim",
    event = "VeryLazy",
    cmd = "Copilot",
    config = function()
      local keymap = vim.keymap.set
      keymap("i", "<C-n>", "<Plug>(copilot-next)")
      keymap("i", "<C-p>", "<Plug>(copilot-previous)")
      keymap("i", "<C-e>", "<Plug>(copilot-dismiss)")
      keymap("i", "<leader><Space>", "<Plug>(copilot-suggest)")

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
    event = "VeryLazy",
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
