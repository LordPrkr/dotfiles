require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },

		javascript = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },

		typescript = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },

		javascriptreact = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },

		typescriptreact = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },

		json = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },

		jsonc = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },

		markdown = { "prettierd", "prettier", stop_after_first = true },

		go = { "goimports", "gofmt" },

		rust = { "rustfmt" },

		terraform = { "terraformfmt" },

		haskell = { "fourmolu" },

		kotlin = { "ktlint" },
	},

	formatters = {
		oxfmt = {
			require_cwd = true,
		},
		["biome-check"] = {
			-- Require biome.json in cwd, otherwise fallback to prettier
			require_cwd = true,
		},
		fourmolu = {
			command = "fourmolu",
			args = { "--stdin-input-file ." },
			stdin = true,
		},
	},
})
