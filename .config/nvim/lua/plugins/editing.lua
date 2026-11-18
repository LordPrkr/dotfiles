return {
	"tpope/vim-sleuth",

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"javascript",
				"typescript",
				"rust",
				"go",
				"json",
				"c",
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
				"query",
			})
		end,
	},

	{ "windwp/nvim-autopairs", opts = {} },

	"windwp/nvim-ts-autotag",

	{ "kylechui/nvim-surround", version = "*", opts = {} },

	{ "Wansmer/treesj", opts = {} },

	{
		"mbbill/undotree",
		init = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},

	{
		"andrewferrier/wrapping.nvim",

		config = function()
			local wrapping = require("wrapping")

			wrapping.setup({
				create_commands = false,
				create_keymaps = false,
				notify_on_switch = true,
				auto_set_mode_filetype_allowlist = {
					"asciidoc",
					"gitcommit",
					"latex",
					"mail",
					"markdown",
					"rst",
					"tex",
					"text",
					"markdown.mdx",
				},
				softener = {
					["markdown.mdx"] = true,
				},
			})

			-- Manually create commands and keymaps
			vim.api.nvim_create_user_command("SoftWrapMode", function()
				wrapping.soft_wrap_mode()
			end, {
				desc = "Set wrap mode to 'soft'",
			})
			vim.api.nvim_create_user_command("HardWrapMode", function()
				wrapping.hard_wrap_mode()
			end, {
				desc = "Set wrap mode to 'hard'",
			})
			vim.api.nvim_create_user_command("ToggleWrapMode", function()
				wrapping.toggle_wrap_mode()
			end, {
				desc = "Toggle wrap mode",
			})

			vim.keymap.set("n", "[ow", function()
				wrapping.soft_wrap_mode()
			end, { desc = "Soft wrap mode", unique = true })
			vim.keymap.set("n", "]ow", function()
				wrapping.hard_wrap_mode()
			end, { desc = "Hard wrap mode", unique = true })
			vim.keymap.set("n", "yow", function()
				wrapping.toggle_wrap_mode()
			end, { desc = "Toggle wrap mode", unique = true })
		end,
	},
}
