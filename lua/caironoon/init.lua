local config = require("caironoon.config")
local M = {}

---Apply the colorscheme (same as ':colorscheme caironoon')
function M.colorscheme()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "caironoon"
	require("caironoon.highlights").setup()
	require("caironoon.terminal").setup()
end

---Setup caironoon.nvim options, without applying colorscheme
---@param options table: a table containing options
function M.setup(options)
	config.extend(options)
end

function M.load()
	vim.api.nvim_command("colorscheme caironoon")
end

return M
