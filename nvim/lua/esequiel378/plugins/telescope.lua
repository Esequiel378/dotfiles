local M = {}

M.setup = function(use)
  use {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    module = "telescope",
    keys = { "<leader>t", "<leader>ps" },
    config = M.config,
    wants = {
      "plenary.nvim",
      "popup.nvim",
      "telescope-fzf-native.nvim",
    },
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
  }
end

M.config = function()
  local map = require("esequiel378.utils").map

  map("n", "<leader>t", ":Telescope find_files hidden=false <CR>")
  map("n", "<leader>ps", ":Telescope live_grep <CR>")
  map("n", "<leader>fw", ":Telescope grep_string <CR>")
  map("n", "<leader>fb", ":Telescope buffers <CR>")

  local actions = require "telescope.actions"
  local telescope = require "telescope"

  -- Custom previewer
  local previewers = require "telescope.previewers"
  local Job = require "plenary.job"

  local preview_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job
    :new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]

        if mime_type == "text" then
          -- Check file size
          vim.loop.fs_stat(filepath, function(_, stat)
            if not stat then
              return
            end
            if stat.size > 500000 then
              return
            else
              previewers.buffer_previewer_maker(filepath, bufnr, opts)
            end
          end)
        else
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY FILE" })
          end)
        end
      end,
    })
    :sync()
  end

  telescope.setup {
    defaults = {
      buffer_previewer_maker = preview_maker,
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      file_ignore_patterns = { "node_modules", "%.git/", "%.local" },
      path_display = { "absolute" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
    },
  }

  telescope.load_extension "fzf"
end

return M
