return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>pf", function()
				MiniFiles.close()
				builtin.find_files()
			end, {})
			vim.keymap.set("n", "<C-p>", function()
				MiniFiles.close()
				builtin.git_files()
			end, {})
			vim.keymap.set("n", "<leader>ph", function()
				MiniFiles.close()
				builtin.command_history()
			end, {})
			vim.keymap.set("n", "<leader>pw", builtin.grep_string)
			vim.keymap.set("n", "gd", builtin.lsp_definitions)
			vim.keymap.set("n", "gD", builtin.lsp_type_definitions)
			vim.keymap.set("n", "gI", builtin.lsp_implementations)
			vim.keymap.set("n", "<leader>bs", builtin.lsp_document_symbols)
			vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols)
			vim.keymap.set("n", "<leader>pr", builtin.lsp_references)
			vim.keymap.set("n", "<leader>pp", builtin.builtin)
			vim.keymap.set("n", "<leader>pe", builtin.diagnostics)

			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end)

			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local make_entry = require("telescope.make_entry")
			local conf = require("telescope.config").values

			local live_multigrep = function(opts)
				opts = opts or {}
				opts.cwd = opts.cwd or vim.uv.cwd()

				local finder = finders.new_async_job({
					command_generator = function(prompt)
						if not prompt or prompt == "" then
							return nil
						end

						local pieces = vim.split(prompt, ":")
						local args = { "rg" }
						if pieces[1] then
							table.insert(args, "-e")
							table.insert(args, pieces[1])
						end

						if pieces[2] then
							table.insert(args, "-g")
							table.insert(args, pieces[2])
						end

						return vim.list_extend(args, {
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
						})
					end,
					entry_maker = make_entry.gen_from_vimgrep(opts),
					cwd = opts.cwd,
				})

				pickers
					.new(opts, {
						debounce = 100,
						prompt_title = "Multi Grep",
						finder = finder,
						previewer = conf.grep_previewer(opts),
						sorter = require("telescope.sorters").empty(),
					})
					:find()
			end

			vim.keymap.set("n", "<leader>ps", function(opts)
				MiniFiles.close()
				live_multigrep(opts)
			end, {})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<C-h>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-t>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-S-P>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-S-N>", function()
				harpoon:list():next()
			end)
		end,
	},

	{ "kevinhwang91/nvim-bqf", ft = "qf" },
}
