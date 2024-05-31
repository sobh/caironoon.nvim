local M = {}
local p = require('caironoon.palette')
local opts = require("caironoon.config").options

function M.setup()
	if not opts.term_colors then return end

	vim.g.terminal_color_0 = p.bg.base[0]
	vim.g.terminal_color_1 = p.fg.red
	vim.g.terminal_color_2 = p.fg.green
	vim.g.terminal_color_3 = p.fg.yellow
	vim.g.terminal_color_4 = p.fg.blue
	vim.g.terminal_color_5 = p.fg.purple
	vim.g.terminal_color_6 = p.fg.cyan
	vim.g.terminal_color_7 = p.bg.base[3]

	vim.g.terminal_color_8  = p.bg.base[2]
	vim.g.terminal_color_9  = p.fg.red
	vim.g.terminal_color_10 = p.fg.green
	vim.g.terminal_color_11 = p.fg.yellow
	vim.g.terminal_color_12 = p.fg.blue
	vim.g.terminal_color_13 = p.fg.grape
	vim.g.terminal_color_14 = p.fg.cyan
	vim.g.terminal_color_15 = p.bg.base[4]
end

return M
