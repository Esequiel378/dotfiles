return {
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
		config = function()
			require("go").setup({
				goimports = "gopls",
				gofmt = "gofumpt",
				comment_placeholder = "",
				lsp_keymaps = false,
				dap_debug = true,
				lsp_codelens = true,
				lsp_inlay_hints = {
					enable = false,
				},
			})

			-- Format and organize imports on save
			local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimports()
				end,
				group = format_sync_grp,
			})
		end,
	},
	{
		"rafaelsq/nvim-goc.lua",
		ft = { "go" },
		-- stylua: ignore
		keys = {
			{ "<leader>gcr", function() require("nvim-goc").Coverage() end,      desc = "Go Coverage Run", },
			{ "<leader>gcc", function() require("nvim-goc").ClearCoverage() end, desc = "Go Coverage Clear", },
			{ "<leader>gct", function() require("nvim-goc").CoverageFunc() end,  desc = "Go Coverage Function", },
			{ "<leader>ga",  function() require("nvim-goc").Alternate() end,     desc = "Go Alternate File", },
		},
		config = function()
			vim.opt.switchbuf = "useopen"
			require("nvim-goc").setup({
				verticalSplit = false,
			})
		end,
	},
}
