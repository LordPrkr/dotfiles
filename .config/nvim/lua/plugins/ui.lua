return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			term_colors = true,
			color_overrides = {
				mocha = {
					base = "#202023",
					mantle = "#202023",
					crust = "#2c2e34",
				},
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				harpoon = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				noice = true,
				telescope = true,
				treesitter = true,
			},
		},
	},

	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.ai").setup({
				n_lines = 500,
			})

			-- MiniFiles clears netrw's FileExplorer autocommands during setup.
			vim.cmd.packadd("netrw")
			require("mini.files").setup({
				mappings = {
					go_in = "<leader><CR>",
					go_in_plus = "<cr>",
					go_out = "<leader>-",
					go_out_plus = "-",
				},
				windows = {
					preview = true,
					width_focus = 50,
					width_preview = 50,
				},
			})

			vim.keymap.set("n", "<leader>pv", function()
				if not MiniFiles.close() then
					MiniFiles.open(vim.api.nvim_buf_get_name(0))
				end
			end)

			local starter = require("mini.starter")

			local header_art = [[
███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄
███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄
███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███
███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███
███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███
███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███
███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███
 ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀
]]

			local footer = "We who cut mere stones must always be envisioning cathedrals."

			starter.setup({
				header = header_art,
				content_hooks = {
					starter.gen_hook.adding_bullet("⇝ "),
					starter.gen_hook.aligning("center", "center"),
				},
				evaluate_single = true,
				footer = footer,
				items = {
					{
						action = "Telescope oldfiles",
						name = "O: Old Files",
						section = "Telescope",
					},
					{
						action = "Telescope command_history",
						name = "H: Command History",
						section = "Telescope",
					},
					{
						action = "vertical bo Git",
						name = "G: Fugitive",
						section = "Git",
					},
					{
						action = "edit ~/.config | lua vim.api.nvim_set_current_dir('~/.config')",
						name = "C: Edit .config",
						section = "Config",
					},
					{
						action = "Lazy",
						name = "L: Lazy",
						section = "Plugins",
					},
					{
						action = function()
							vim.cmd.edit(vim.fn.stdpath("config") .. "/lua/plugins")
							vim.api.nvim_set_current_dir(vim.fn.stdpath("config"))
						end,
						name = "P: Plugins",
						section = "Plugins",
					},
					{
						action = "enew",
						name = "E: New Buffer",
						section = "Builtin actions",
					},
					{
						action = "qall!",
						name = "Q: Quit Neovim",
						section = "Builtin actions",
					},
				},
			})
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "andrewferrier/wrapping.nvim" },
		opts = {
			options = {
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = { "filetype" },
				lualine_y = {
					"require'wrapping'.get_current_mode()",
				},
				lualine_z = { "progress" },
			},
			extensions = {
				"toggleterm",
				"fugitive",
			},
		},
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			messages = {
				-- NOTE: If you enable messages, then the cmdline is enabled automatically.
				-- This is a current Neovim limitation.
				enabled = true, -- enables the Noice messages UI
				view = "mini", -- default view for messages
				view_error = "mini", -- view for errors
				view_warn = "mini", -- view for warnings
				view_history = "mini", -- view for :messages
				view_search = "mini", -- view for search count messages. Set to `false` to disable
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			notify = { view = "mini" },
			routes = {
				{
					view = "mini",
					filter = { event = "msg_showmode", find = "recording" },
				},
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })
			end,
		},
	},

	{
		"tpope/vim-fugitive",
		init = function()
			vim.keymap.set("n", "<leader>gs", function()
				vim.cmd("vertical bo Git")
			end)
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local toggleterm = require("toggleterm")
			toggleterm.setup({
				open_mapping = [[<c-\>]],
				size = vim.o.columns * 0.4,
				direction = "vertical",
			})

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},
}
