return {
  { "kylechui/nvim-surround", event = "VeryLazy", },
  { "tpope/vim-surround",     event = "VeryLazy" },
  { "tpope/vim-sleuth",       event = "VeryLazy" },
  { "tpope/vim-repeat",       event = "VeryLazy" },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = {
      { "gc",  mode = { "n", "v" } },
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
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = false,
          accept = false,
          debounce = 75,
          keymap = {
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<C-e>",
          },
        },
      })

      vim.keymap.set("i", '<Tab>', function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
          return
        end

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
      end, {
        silent = true,
      })
    end,
  }
}
