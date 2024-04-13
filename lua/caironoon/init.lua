local config = require("caironoon.config")
local M = {}

---Apply the colorscheme (same as ':colorscheme caironoon')
function M.colorscheme(variant)

	config.extend({ variant = variant })

	vim.cmd("hi clear")
	vim.cmd("syntax reset")

	if vim.env.TERM ~= "linux" then
		vim.o.termguicolors = true
	end

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
