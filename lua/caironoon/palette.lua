local oc = require("caironoon.open-color")

local dark = {
	black = oc.black,
	bg0 = oc.gray[10],
	bg1 = oc.gray[9],
	bg2 = oc.gray[8],
	bg3 = oc.gray[7],
	bg_d = oc.black,
	bg_blue = oc.blue[5],
	bg_yellow = oc.yellow[2],
	fg = oc.gray[5],

	gray = oc.gray[7],
	red = oc.red[4],
	orange = oc.orange[4],
	yellow = oc.yellow[4],
	lime = oc.lime[4],
	green = oc.green[4],
	teal = oc.teal[4],
	cyan = oc.cyan[4],
	blue = oc.blue[4],
	indigo = oc.indigo[4],
	violet = oc.violet[4],
	grape = oc.grape[4],
	pink = oc.pink[4],

	light_gray = oc.gray[6],
	dark_cyan = oc.cyan[10],
	dark_red = oc.red[10],
	dark_yellow = oc.yellow[10],
	dark_purple = oc.grape[10],

	diff_add = oc.green[10],
	diff_delete = oc.red[10],
	diff_change = oc.blue[10],
	diff_text = oc.gray[9],
}
local light = {
	black = oc.black,
	bg0 = oc.gray[1],
	bg1 = oc.gray[3],
	bg2 = oc.gray[4],
	bg3 = oc.gray[5],
	bg_d = oc.gray[6],
	bg_blue = oc.blue[4],
	bg_yellow = oc.yellow[5],
	fg = oc.black,

	grey = oc.gray[8],
	red = oc.red[10],
	orange = oc.orange[10],
	yellow = oc.yellow[10],
	lime = oc.lime[10],
	green = oc.green[10],
	teal = oc.teal[10],
	cyan = oc.cyan[10],
	blue = oc.blue[10],
	indigo = oc.indigo[10],
	violet = oc.violet[10],
	grape = oc.grape[10],
	pink = oc.pink[10],

	light_grey = oc.gray[7],
	dark_cyan = oc.cyan[10],
	dark_red = oc.red[10],
	dark_yellow = oc.yellow[10],
	dark_purple = oc.grape[10],

	diff_add = oc.green[2],
	diff_delete = oc.red[2],
	diff_change = oc.blue[2],
	diff_text = oc.gray[5],
}

if vim.opt.background:get() == "dark" then
	return dark
else
	return light
end
