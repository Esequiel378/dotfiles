return {
  {
    "ThePrimeagen/harpoon",
    --stylua: ignore
    keys = {
      { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Add File" },
      { "<leader>hm", function() require("harpoon.ui").toggle_quick_menu() end, desc = "File Menu" },
      { "1", function() require("harpoon.ui").nav_file(1) end, desc = "File 1" },
      { "2", function() require("harpoon.ui").nav_file(2) end, desc = "File 2" },
      { "3", function() require("harpoon.ui").nav_file(3) end, desc = "File 3" },
    },
    opts = {
      global_settings = {
        save_on_toggle = true,
        enter_on_sendcmd = true,
      },
    },
  },
}
