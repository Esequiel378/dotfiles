local function format_frontend(file_path)
	return {
		-- the first task
		---@class format.config
		---@field cmd string
		---@field args string[]
		---@field options {env?: table<string, any>, cwd?: string, uid?: number, gid?: number, verbatim?: boolean, detached?: boolean, hide?: boolean, timeout?: number} | nil
		---@field on_success fun(code: integer, signal: integer) | nil
		---@field on_err fun(err: string | nil, data: string | nil) | nil
		---@field ignore_err (fun(err: string | nil, data: string | nil): boolean) | nil
		{
			cmd = "prettier",
			args = {
				-- this plugin copies content of current buffer to a temporary file, and format this file, then write back to the buffer, thus, you need to make sure the formatter can write to the file
				"-w",
				file_path,
			},
			-- some formatters may output to stderr when formatted successfully, use this function to ignore these errors
			ignore_err = function(err, data)
				return err == nil and data == nil
			end,
		},
		-- the second task
		{
			cmd = "eslint_d",
			args = {
				"--fix",
				file_path,
			},
			-- just try to fix error with eslint, ignore the errors whether it succeed or not
			ignore_err = function()
				return true
			end,
			-- only the last task's `on_success` works
			-- all tasks's `on_err` works
			on_success = function()
				print("format success")
			end,
		},
	}
end

return {
	{
		"niuiic/format.nvim",
		dependencies = { "niuiic/core.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("format").setup({
				hooks = {
					---@type fun(code: integer, signal: integer) | nil
					on_success = function()
						vim.notify("Formatting Succeed", vim.log.levels.INFO, { title = "Format" })
					end,
					---@type fun(err: string | nil, data: string | nil) | nil
					on_err = function()
						vim.notify("Formatting Failed", vim.log.levels.ERROR, { title = "Format" })
					end,
					on_timeout = function()
						vim.notify("Formatting Timeout", vim.log.levels.ERROR, { title = "Format" })
					end,
				},
				filetypes = {
					-- stylua
					lua = require("format.builtins.stylua"),
					-- rustfmt
					rust = require("format.builtins.rustfmt"),
					-- prettier
					javascript = format_frontend,
					svelte = format_frontend,
					typescript = format_frontend,
					javascriptreact = format_frontend,
					typescriptreact = format_frontend,
					markdown = require("format.builtins.prettier"),
					css = require("format.builtins.prettier"),
					scss = require("format.builtins.prettier"),
					less = require("format.builtins.prettier"),
					html = require("format.builtins.prettier"),
					json = require("format.builtins.prettier"),
					jsonc = require("format.builtins.prettier"),
					yaml = require("format.builtins.prettier"),
					plaintex = require("format.builtins.prettier"),
					-- black
					python = require("format.builtins.black"),
					-- shfmt
					sh = require("format.builtins.shfmt"),
					zsh = require("format.builtins.shfmt"),
					dockerfile = require("format.builtins.shfmt"),
					-- sqlfluff
					sql = require("format.builtins.sqlfluff"),
					-- taplo
					toml = require("format.builtins.taplo"),
					-- golines
					go = require("format.builtins.golines"),
					-- nginxbeautifier
					nginx = require("format.builtins.nginxbeautifier"),
				},
			})
		end,
	},
}
