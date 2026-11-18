-- Lualine's auto theme picks this up when :colorscheme merino-dark is active.
local function section(group)
	local hl = vim.api.nvim_get_hl(0, { name = group })
	return { fg = ("#%06x"):format(hl.fg), bg = ("#%06x"):format(hl.bg) }
end

local active = section("StatusLine")
local inactive = section("StatusLineNC")
local body = { fg = active.fg, bg = active.bg }
local secondary = { fg = inactive.fg, bg = active.bg }

local function mode(accent)
	return { a = { fg = accent, bg = "#142134", gui = "bold" }, b = secondary, c = body }
end

return {
	normal = mode("#79c0ff"),
	insert = mode("#56d364"),
	visual = mode("#d2a8ff"),
	replace = mode("#ffa198"),
	command = mode("#e3b341"),
	terminal = mode("#56d4dd"),
	inactive = { a = inactive, b = inactive, c = inactive },
}
