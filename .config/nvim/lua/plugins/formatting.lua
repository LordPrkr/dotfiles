local web_formatters = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true }
local format_opts = { timeout_ms = 3000, lsp_format = "never" }

return {
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = format_opts,
			notify_no_formatters = false,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = web_formatters,
				typescript = web_formatters,
				javascriptreact = web_formatters,
				typescriptreact = web_formatters,
				json = web_formatters,
				jsonc = web_formatters,
				markdown = { "prettierd", "prettier", stop_after_first = true },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				terraform = { "terraformfmt" },
				haskell = { "fourmolu" },
				kotlin = { "ktlint" },
			},
			formatters = {
				oxfmt = { require_cwd = true },
				["biome-check"] = { require_cwd = true },
				fourmolu = {
					command = "fourmolu",
					args = { "--stdin-input-file ." },
					stdin = true,
				},
			},
		},
		init = function()
			vim.api.nvim_create_user_command("Format", function()
				if vim.bo.buftype == "" then
					require("conform").format(vim.deepcopy(format_opts))
				end
			end, { desc = "Format the current buffer" })
			vim.keymap.set("n", "<leader>f", "<cmd>Format<CR>", { desc = "Format buffer" })
		end,
	},
}
