return {
	"tpope/vim-sleuth",
	{ "kylechui/nvim-surround", event = "VeryLazy" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "tpope/vim-sleuth", event = "VeryLazy" },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"editorconfig/editorconfig-vim",
		lazy = false,
		config = function()
			vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
			vim.api.nvim_del_user_command("EditorConfigEnable")
			vim.api.nvim_del_user_command("EditorConfigReload")
			vim.api.nvim_del_user_command("EditorConfigDisable")
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
			{ "gc", mode = { "n", "v" } },
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

			vim.keymap.set("i", "<Tab>", function()
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
		"tpope/vim-fugitive",
		cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit", "G" },
		keys = {
			{ "<leader>gs", "<cmd>:G<CR><C-w>T", desc = "Git Status" },
		},
	},
}
