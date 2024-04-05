--
-- Description: Provide Simple Interface to the HSLuv Color Space
--

local hsluv = require("caironoon.colors.hsluv.hsluv")

local M = {}

local hues_offset = 10
M.hues = {
	red    = hues_offset +   0,
	orange = hues_offset +  30,
	yellow = hues_offset +  60,
	lime   = hues_offset +  90,
	green  = hues_offset + 120,
	teal   = hues_offset + 150,
	cyan   = hues_offset + 180,
	blue   = hues_offset + 210,
	indigo = hues_offset + 240,
	violet = hues_offset + 270,
	grape  = hues_offset + 300,
	pink   = hues_offset + 330,
}

M.color = function (hue, level)
	local sat   = { min = 40.0, max = 100.0 }
	local light = { min = 20.0, max =  95.0 }
	sat.scale   = sat.max   - sat.min
	light.scale = light.max - light.min
	local saturation = sat.min   + level * sat.scale   / 100.0
	local lightness  = light.max - level * light.scale / 100.0
	return hsluv.hsluv_to_hex({hue, saturation, lightness})
end

return M
