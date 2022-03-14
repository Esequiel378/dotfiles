local M = {}

function M.setup(use)
   use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
         require("plugins.config.treesitter").config()
      end,
   }
end

function M.config()
   require("nvim-treesitter.configs").setup {
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = {
         "lua",
      },

      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,
      autopairs = {
         enable = true,
      },
      highlight = {
         enable = true,
         use_languagetree = true,
         additional_vim_regex_highlighting = true,
      },
      context_commentstring = {
         enable = true,
      },
      endwise = {
         enable = true,
      },
   }
end

return M
