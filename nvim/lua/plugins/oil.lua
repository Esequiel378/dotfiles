return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      { "echasnovski/mini.icons", opts = {} }
    },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = false,
        watch_for_changes = true,
        prompt_save_on_select_new_entry = true,
        use_default_keymaps = true,
        columns = {
          "icon",
        },
        view_options = {
          show_hidden = true,
        },
        win_options = {
          winbar = "%#@attribute.builtin#%{substitute(v:lua.require('oil').get_current_dir(), '^' . $HOME, '~', '')}",
        }
      })

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  }
}
