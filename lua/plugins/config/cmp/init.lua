local M = {}

function M.setup(use)
    use {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        opt = true,
        config = function()
            require("plugins.config.cmp").config()
        end,
        wants = { "LuaSnip" },
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                wants = "friendly-snippets",
                config = function()
                    require("plugins.config.cmp.snippets").config()
                end,
            },
            "rafamadriz/friendly-snippets",
            disable = false,
        },
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("plugins.config.cmp.autopairs").config()
      end,
    }

    -- Auto tag
    use {
        "windwp/nvim-ts-autotag",
        wants = "nvim-treesitter",
        event = "InsertEnter",
        config = function()
            require("nvim-ts-autotag").setup { enable = true }
        end,
    }

    -- End wise
    use {
        "RRethy/nvim-treesitter-endwise",
        wants = "nvim-treesitter",
        event = "InsertEnter",
    }
end

function M.config()
    local luasnip = require "luasnip"
    local cmp = require "cmp"

    cmp.setup {
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        experimental = {
            native_menu = false,
            ghost_text = false
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    luasnip = "[Snip]",
                    nvim_lua = "[Lua]",
                    treesitter = "[Treesitter]",
                })[entry.source.name]
                return vim_item
            end,
        },
        mapping = {
            ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-e>"] = cmp.mapping { i = cmp.mapping.close(), c = cmp.mapping.close() },
            ["<C-y>"] = cmp.mapping {
                i = function()
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
                    end
                end,
                c = function(fallback)
                    if cmp.visible() then
                        cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
                    else
                        fallback()
                    end
                end,
            },
    },
    sources = {
        { name = "treesitter" },
        { name = "buffer" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "emoji" },
    },
    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
    },
}

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- Auto pairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
end

return M
