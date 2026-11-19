-- Local trial only. Remove this file to restore the Catppuccin default.
local preview = vim.fn.expand("~/dotfiles-merino-dark/.config/nvim")
if vim.uv.fs_stat(preview .. "/colors/merino-dark.lua") then
	vim.opt.runtimepath:prepend(preview)
	vim.cmd.colorscheme("merino-dark")
end
