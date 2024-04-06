local oc = require("caironoon.colors.open-color")
local hsluv = require("caironoon.colors.hsluv")
local options = require("caironoon.config").options

local palette = {
	dark = {

		open_color = {
			black = oc.black,
			fg = oc.gray[5],
			bg = {
				[1] = oc.gray[10],
				[2] = oc.gray[9],
				[3] = oc.gray[8],
				[4] = oc.gray[7],

				dark = oc.black,
				blue = oc.blue[5],
				yellow = oc.yellow[2],
			},

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

			syntax = {
				comment = oc.gray[7],

				diff = {
					add = { bg = oc.green[10] },
					delete = { bg = oc.red[10] },
					change = { bg = oc.blue[10] },
					text = { bg = oc.gray[9] },
				},

				diag = {
					error = { fg = oc.red[10] },
					warning = { fg = oc.yellow[10] },
					info = { fg = oc.cyan[10] },
					hint = { fg = oc.violet[10] },
				},

			},

		},

		hsluv = {
			black = oc.black,
			fg = oc.gray[5],
			bg = {
				[1] = oc.gray[10],
				[2] = oc.gray[9],
				[3] = oc.gray[8],
				[4] = oc.gray[7],

				dark = oc.black,
				blue = oc.blue[5],
				yellow = oc.yellow[2],
			},

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

			syntax = {
				comment = oc.gray[7],

				diff = {
					add = { bg = oc.green[10] },
					delete = { bg = oc.red[10] },
					change = { bg = oc.blue[10] },
					text = { bg = oc.gray[9] },
				},

				diag = {
					error = { fg = oc.red[10] },
					warning = { fg = oc.yellow[10] },
					info = { fg = oc.cyan[10] },
					hint = { fg = oc.violet[10] },
				},

			},

		},

	},

	light = {
		open_color = {
			black = oc.black,
			fg = oc.black,
			bg = {
				[1] = oc.white,
				[2] = oc.gray[3],
				[3] = oc.gray[4],
				[4] = oc.gray[5],

				dark = oc.gray[6],
				blue = oc.blue[4],
				yellow = oc.yellow[5],
			},

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

			syntax = {
				comment = oc.gray[8],

				diff = {
					add    = {
						fg = oc.green[10],
						bg = oc.green[1],
					},
					delete = { bg = oc.red[2] },
					change = { bg = oc.blue[2] },
					text   = { bg = oc.gray[5] },
				},

				diag = {
					error = { fg = oc.red[10] },
					warning = { fg = oc.yellow[10] },
					info = { fg = oc.cyan[10] },
					hint = { fg = oc.violet[10] },
				},

			},

		},

		hsluv = {
			black = hsluv.black,
			fg = hsluv.black,
			bg = {
				[1] = hsluv.white,
				[2] = oc.gray[3],
				[3] = oc.gray[4],
				[4] = oc.gray[5],

				dark = oc.gray[6],
				blue = oc.blue[4],
				yellow = oc.yellow[5],
			},

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

			syntax = {
				comment = oc.gray[8],

				diff = {
					add    = {
						fg = hsluv.color(hsluv.hues.green, 100),
						bg = hsluv.color(hsluv.hues.green,   5),
					},
					delete = {
						fg = hsluv.color(hsluv.hues.red, 100),
						bg = hsluv.color(hsluv.hues.red,   5),
					},
					change = {
						fg = hsluv.color(hsluv.hues.blue, 100),
						bg = hsluv.color(hsluv.hues.blue,   5),
					},
					text   = {
						fg = hsluv.gray(90),
						bg = hsluv.gray(10),
					},
				},

				diag = {
					error = { fg = oc.red[10] },
					warning = { fg = oc.yellow[10] },
					info = { fg = oc.cyan[10] },
					hint = { fg = oc.violet[10] },
				},

			},

		},
	},

}

local p = palette[vim.opt.background:get()]
if p[options.variant] ~= nil then
	return p[options.variant]
else
	return p.open_color
end
