return {
  { "kylechui/nvim-surround", event = "VeryLazy", },
  { "tpope/vim-surround",     event = "VeryLazy" },
  { "tpope/vim-sleuth",       event = "VeryLazy" },
  { "tpope/vim-repeat",       event = "VeryLazy" },
  {
    "editorconfig/editorconfig-vim",
    lazy = false,
    config = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
      vim.api.nvim_del_user_command('EditorConfigEnable')
      vim.api.nvim_del_user_command('EditorConfigReload')
      vim.api.nvim_del_user_command('EditorConfigDisable')
    end,
  },
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
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local icons = require "config.icons"
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local compare = require "cmp.config.compare"

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      cmp.setup {
        view = {
          entries = {
            name = 'custom',
            selection_order = 'top_down',
          },
          docs = {
            auto_open = true,
          },
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            compare.score,
            compare.recently_used,
            compare.offset,
            compare.exact,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping {
            i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
              else
                fallback()
              end
            end,
          },
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp", group_index = 1 },
          { name = "luasnip",  group_index = 1 },
          { name = "buffer",   group_index = 2 },
          { name = "emoji",    group_index = 2 },
          { name = "path",     group_index = 2 },
        },
        formatting = {},
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local max_width = 0
          local source_names = {
            nvim_lsp = "[LSP]",
            path = "[Path]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            emoji = "[Emoji]",
          }
          local duplicates = {
            buffer = 1,
            path = 1,
            nvim_lsp = 0,
            luasnip = 1,
          }
          local duplicates_default = 0
          if max_width ~= 0 and #item.abbr > max_width then
            item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
          end
          item.kind = icons.kind[item.kind]
          item.menu = source_names[entry.source.name]
          item.dup = duplicates[entry.source.name] or duplicates_default
          return item
        end,
      }

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    build = "make install_jsregexp",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        -- TODO: define a better keymap for this
        "<C-Tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
        end,
        expr = true,
        remap = true,
        silent = true,
        mode = "i",
      },
      -- TODO: define a better keymap for this
      { "<C-Tab>", function() require("luasnip").jump(1) end,  mode = "s" },
      { "<S-Tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function(_, opts)
      require("luasnip").setup(opts)
    end,
  },
}
