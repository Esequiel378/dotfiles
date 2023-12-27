return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    'nvim-lua/plenary.nvim',
  },
  cmd = "Telescope",
  -- stylua: ignore
  keys = {
    { "<leader>tt", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    { "<leader>tg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
    { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    {
      "<leader>tc",
      function()
        require("telescope.builtin").colorscheme { enable_preview = true }
      end,
      desc = "Colorscheme",
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-n>"] = function(...)
            require("telescope.actions").move_selection_next(...)
          end,
          ["<C-p>"] = function(...)
            require("telescope.actions").move_selection_previous(...)
          end,
        },
      },
    },
  },
  config = function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)
    telescope.load_extension "fzf"
  end,
}
