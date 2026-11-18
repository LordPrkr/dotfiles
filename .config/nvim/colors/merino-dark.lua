-- sRGB colors from Rex's bundled Merino Dark theme (SuperDesignTokens).
local ansi = {
	"#484f58",
	"#ff7b72",
	"#3fb950",
	"#d29922",
	"#58a6ff",
	"#bc8cff",
	"#39c5cf",
	"#b1bac4",
	"#6e7681",
	"#ffa198",
	"#56d364",
	"#e3b341",
	"#79c0ff",
	"#d2a8ff",
	"#56d4dd",
	"#ffffff",
}
local background = "#0d1117"
local foreground = "#e6edf3"
local selection = "#142134"
local raised = "#1e2023"
local muted = "#82878c"

vim.o.background = "dark"
require("mini.base16").setup({
	palette = {
		base00 = background,
		base01 = raised,
		base02 = "#2e3135",
		base03 = muted,
		base04 = ansi[8],
		base05 = foreground,
		base06 = foreground,
		base07 = ansi[16],
		base08 = ansi[2],
		base09 = ansi[10],
		base0A = ansi[12],
		base0B = ansi[11],
		base0C = ansi[7],
		base0D = ansi[5],
		base0E = ansi[6],
		base0F = ansi[13],
	},
})

local highlights = {
	Cursor = { fg = background, bg = ansi[16] },
	-- Keep the gutter flush with the editor, not the raised UI surfaces.
	LineNr = { fg = muted, bg = background },
	LineNrAbove = { link = "LineNr" },
	LineNrBelow = { link = "LineNr" },
	CursorLineNr = { fg = ansi[13], bg = background, bold = true },
	SignColumn = { link = "LineNr" },
	CursorLineSign = { link = "SignColumn" },
	FoldColumn = { fg = ansi[7], bg = background },
	CursorLineFold = { link = "FoldColumn" },
	GitSignsAdd = { fg = ansi[11], bg = background },
	GitSignsChange = { fg = ansi[6], bg = background },
	GitSignsDelete = { fg = ansi[2], bg = background },
	GitSignsUntracked = { fg = ansi[5], bg = background },
	StatusLine = { fg = foreground, bg = "#0f1319" },
	StatusLineNC = { fg = muted, bg = background },
	Visual = { bg = selection },
	PmenuSel = { fg = foreground, bg = selection, bold = true },
	TelescopeSelection = { link = "PmenuSel" },
	DiagnosticError = { fg = ansi[2] },
	DiagnosticWarn = { fg = ansi[4] },
	DiagnosticInfo = { fg = ansi[5] },
	DiagnosticHint = { fg = ansi[7] },
}
for group, colors in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, colors)
end
for i, color in ipairs(ansi) do
	vim.g["terminal_color_" .. (i - 1)] = color
end
-- The main config leaves cursor styling to the terminal. Opt in for this theme only.
local previous_guicursor = vim.o.guicursor
vim.o.guicursor = "a:block-Cursor"
vim.api.nvim_create_autocmd("ColorSchemePre", {
	once = true,
	callback = function()
		vim.o.guicursor = previous_guicursor
	end,
})
vim.g.colors_name = "merino-dark"
