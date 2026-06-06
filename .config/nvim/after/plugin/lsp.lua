vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>d", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
	end,
})

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

local nvim_lsp = require("lspconfig")

vim.lsp.config("denols", {
	root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
})

-- vim.lsp.config("ts_ls", {
-- 	workspace_required = false,
-- 	cmd_env = { NODE_OPTIONS = "--max-old-space-size=8192" },
-- })

vim.lsp.config("eslint", {
	cmd = {
		"node",
		"--max-old-space-size=8192",
		vim.fn.stdpath("data") .. "/mason/bin/vscode-eslint-language-server",
		"--stdio",
	},
})

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "eslint", "rust_analyzer", "gopls" },
	automatic_enable = { exclude = "hls" },
})

-- Haskell Tools setup
vim.g.haskell_tools = {
	hls = {
		on_attach = function(_, bufnr, ht)
			---
			-- Suggested keymaps from the quick setup section:
			-- https://github.com/mrcjkb/haskell-tools.nvim#quick-setup
			---

			local def_opts = { noremap = true, silent = true, buffer = bufnr }
			-- haskell-language-server relies heavily on codeLenses,lsp
			-- so auto-refresh (see advanced configuration) is enabled by default
			vim.keymap.set("n", "<leader>hca", vim.lsp.codelens.run, def_opts)
			-- Hoogle search for the type signature of the definition under the cursor
			-- vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
			-- Evaluate all code snippets
			vim.keymap.set("n", "<leader>hea", ht.lsp.buf_eval_all, def_opts)
			-- Toggle a GHCi repl for the current package
			vim.keymap.set("n", "<leader>hrr", ht.repl.toggle, def_opts)
			-- Toggle a GHCi repl for the current buffer
			-- vim.keymap.set("n", "<leader>hrf", function()
			--   ht.repl.toggle(vim.api.nvim_buf_get_name(0))
			-- end, def_opts)
			-- vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts)
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
