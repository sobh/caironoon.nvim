local M = {}
local cfg = vim.g.caironoon_config
local p = require 'caironoon.palette'

function M.setup()
    if not cfg.term_colors then return end

    vim.g.terminal_color_0 = p.black
    vim.g.terminal_color_1 = p.red
    vim.g.terminal_color_2 = p.green
    vim.g.terminal_color_3 = p.yellow
    vim.g.terminal_color_4 = p.blue
    vim.g.terminal_color_5 = p.grape
    vim.g.terminal_color_6 = p.cyan
    vim.g.terminal_color_7 = p.fg

    vim.g.terminal_color_8 = p.gray
    vim.g.terminal_color_9 = p.red
    vim.g.terminal_color_10 = p.green
    vim.g.terminal_color_11 = p.yellow
    vim.g.terminal_color_12 = p.blue
    vim.g.terminal_color_13 = p.grape
    vim.g.terminal_color_14 = p.cyan
    vim.g.terminal_color_15 = p.fg
end

return M
