return {
	"tpope/vim-sleuth",

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
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
	},
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", lazy = true } },

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = "false",
		build = ":TSUpdate",
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"mbbill/undotree",

	{ "stevearc/conform.nvim" },

	-- LSP Support
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim" },
			"neovim/nvim-lspconfig",
		},
	},

	-- Autocompletion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "L3MON4D3/LuaSnip" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },

	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",

	{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
	"saadparwaiz1/cmp_luasnip",

	{
		"mrcjkb/haskell-tools.nvim",
		version = "^4",
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
		lazy = false,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
	},

	{
		"kylechui/nvim-surround",
		version = "*",
	},

	"tpope/vim-fugitive",

	"numToStr/Comment.nvim",

	"Wansmer/treesj",

	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	{
		"smjonas/inc-rename.nvim",
	},

	{ "echasnovski/mini.nvim", version = "*" },

	"andrewferrier/wrapping.nvim",

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{ "mistricky/codesnap.nvim", build = "make" },

	-- {
	--   "m4xshen/hardtime.nvim",
	--   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	-- },

	{ "ThePrimeagen/vim-be-good" },

	{ "nvim-telescope/telescope-ui-select.nvim" },

	{
		"oysandvik94/curl.nvim",
		cmd = { "CurlOpen" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
			"DBUISaveQuery",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.dbs = {
				{ name = "dev", url = "postgresql://postgres:postgres@127.0.0.1:5432/postgres" },
			}
		end,
	},
}
