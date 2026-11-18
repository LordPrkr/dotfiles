return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
		},
		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				},

				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-f>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
			})
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		init = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = event.buf, desc = "Show diagnostics" })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				end,
			})
		end,
		config = function()
			local nvim_lsp = require("lspconfig")

			vim.lsp.config("denols", {
				root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
			})

			vim.lsp.config("effect_tsgo", {
				cmd = function(dispatchers, config)
					return vim.lsp.rpc.start(
						{ config.root_dir .. "/node_modules/.bin/tsc", "--lsp", "--stdio" },
						dispatchers
					)
				end,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_markers = { "tsconfig.effect.json" },
			})
			vim.lsp.enable("effect_tsgo")

			vim.lsp.config("eslint", {
				cmd = {
					"node",
					"--max-old-space-size=8192",
					vim.fn.stdpath("data") .. "/mason/bin/vscode-eslint-language-server",
					"--stdio",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "eslint", "rust_analyzer", "gopls" },
				automatic_enable = { exclude = { "hls", "ts_ls" } },
			})
		end,
	},

	{
		"mrcjkb/haskell-tools.nvim",
		version = "^4",
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
		lazy = false,
		init = function()
			vim.g.haskell_tools = {
				hls = {
					on_attach = function(_, bufnr, ht)
						local def_opts = { noremap = true, silent = true, buffer = bufnr }
						-- haskell-language-server relies heavily on codeLenses,lsp
						-- so auto-refresh (see advanced configuration) is enabled by default
						vim.keymap.set("n", "<leader>hca", vim.lsp.codelens.run, def_opts)
						-- Evaluate all code snippets
						vim.keymap.set("n", "<leader>hea", ht.lsp.buf_eval_all, def_opts)
						-- Toggle a GHCi repl for the current package
						vim.keymap.set("n", "<leader>hrr", ht.repl.toggle, def_opts)
					end,
				},
				tools = {
					repl = {
						handler = "toggleterm",
					},
					log = {
						level = vim.log.levels.INFO,
					},
				},
			}
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		opts = {},
		init = function()
			vim.keymap.set("n", "<leader>rn", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, { expr = true })
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		dependencies = { { "Bilal2453/luvit-meta", lazy = true } },
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
}
