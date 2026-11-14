local status, starter = pcall(require, "mini.starter")
if not status then
	return
end

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

local footer = [[
We who cut mere stones must always be envisioning cathedrals.
]]

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
			action = "edit ~/.config/nvim/lua/plugins/init.lua | lua vim.api.nvim_set_current_dir('~/.config/nvim')",
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
