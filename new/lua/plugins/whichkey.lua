return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require "which-key"
    wk.setup {
      show_help = true,
      plugins = { spelling = true },
      key_labels = { ["<leader>"] = "SPC" },
      triggers = "auto",
    }
    wk.register({
      w = { "<cmd>update!<CR>", "Save" },
      q = { "<cmd>lua require('utils').quit()<CR>", "Quit" },
      f = { name = "+File" },
      g = { name = "+Git" },
      c = {
        name = "+Code",
        x = {
          name = "Swap Next",
          f = "Function",
          p = "Parameter",
          c = "Class",
        },
        X = {
          name = "Swap Previous",
          f = "Function",
          p = "Parameter",
          c = "Class",
        },
      },
      s = {
        name = "+Search",
        c = {
          function()
            require("utils.cht").cht()
          end,
          "Cheatsheets",
        },
        s = {
          function()
            require("utils.cht").stack_overflow()
          end,
          "Stack Overflow",
        },
      },
    }, { prefix = "<leader>" })
  end,
}
