return {
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

      local source_names = {
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        luasnip = "[Snippet]",
        emoji = "[Emoji]",
        path = "[Path]",
      }

      local duplicates = {
        nvim_lsp = 0,
        buffer = 1,
        luasnip = 1,
        emoji = 0,
        path = 1,
      }

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      cmp.setup {
        view = "custom",
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
          { name = "luasnip", group_index = 1 },
          { name = "buffer", group_index = 2 },
          { name = "emoji", group_index = 2 },
          { name = "path", group_index = 2 },
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
        "<Tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
        end,
        expr = true,
        remap = true,
        silent = true,
        mode = "i",
      },
      { "<Tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<S-Tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function(_, opts)
      require("luasnip").setup(opts)
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    cmd = "Copilot",
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
    {
      "editorconfig/editorconfig-vim",
      config = function()
        vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
      end,
    },
  },
}
