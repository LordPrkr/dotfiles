require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },

		javascript = { "biome-check", "prettierd", "prettier", stop_after_first = true },

		typescript = { "biome-check", "prettierd", "prettier", stop_after_first = true },

		javascriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },

		typescriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },

		json = { "biome-check", "prettierd", "prettier", stop_after_first = true },

		jsonc = { "biome-check", "prettierd", "prettier", stop_after_first = true },

		markdown = { "prettierd", "prettier", stop_after_first = true },

		go = { "goimports", "gofmt" },

		rust = { "rustfmt" },

		terraform = { "terraformfmt" },

		haskell = { "fourmolu" },

		kotlin = { "ktlint" },
	},

	formatters = {
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
