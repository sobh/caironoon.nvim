local oc = require("caironoon.colors.open-color")

local term = {
	dark = {
		fg = {
			base = "LightGray",
			gray    = "LightGray",
			red     = "LightRed",
			yellow  = "LightYellow",
			green   = "LightGreen",
			cyan    = "LightCyan",
			blue    = "LightBlue",
			magenta = "LightMagenta",
		},
		bg = {
			[1] = "Black",
			[2] = "DarkGray",
			[3] = "LightGray",
			[4] = "White",
			gray    = "DarkGray",
			red     = "DarkRed",
			yellow  = "DarkYellow",
			green   = "DarkGreen",
			cyan    = "DarkCyan",
			blue    = "DarkBlue",
			magenta = "DarkMagenta",
		},
		syntax = {
			comment = "DarkGray",
			diff = {
				add    = {
					fg = "LightGreen",
					bg = "DarkGreen",
				},
				delete = {
					fg = "LightRed",
					bg = "DarkRed",
				},
				change = {
					fg = "LightBlue",
					bg = "DarkBlue",
				},
				text   = {
					fg = "LightGray",
					bg = "DarkGray",
				},
			},

			diag = {
				error   = { fg = "LightRed" },
				warning = { fg = "LightYellow" },
				info    = { fg = "LightCyan" },
				hint    = { fg = "LightMagenta" },
			},
		}
	},
	light = {
		fg = {
			base = "Black",
			gray    = "DarkGray",
			red     = "DarkRed",
			yellow  = "DarkYellow",
			green   = "DarkGreen",
			cyan    = "DarkCyan",
			blue    = "DarkBlue",
			magenta = "DarkMagenta",
		},
		bg = {
			[1] = "White",
			[2] = "LightGray",
			[3] = "DarkGray",
			[4] = "Black",
			gray    = "LightGray",
			red     = "LightRed",
			yellow  = "LightYellow",
			green   = "LightGreen",
			cyan    = "LightCyan",
			blue    = "LightBlue",
			magenta = "LightMagenta",
		},
		syntax = {
			comment = "LighGray",
			diff = {
				add    = {
					fg = "DarkGreen",
					bg = "LightGreen",
				},
				delete = {
					fg = "DarkRed",
					bg = "LightRed",
				},
				change = {
					fg = "DarkBlue",
					bg = "LightBlue",
				},
				text   = {
					fg = "DarkGray",
					bg = "LightGray",
				},
			},

			diag = {
				error   = { fg = "DarkRed" },
				warning = { fg = "DarkYellow" },
				info    = { fg = "DarkCyan" },
				hint    = { fg = "DarkMagenta" },
			},
		}
	},
}

local palette = {
	dark = {
			term = term.dark,
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

	light = {
		term = term.light,
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

		gray = oc.gray[8],
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
				delete = {
					fg = oc.red[10],
					bg = oc.red[1],
				},
				change = {
					fg = oc.blue[10],
					bg = oc.blue[1],
				},
				text   = {
					fg = oc.gray[10],
					bg = oc.gray[1],
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

}

return palette[vim.opt.background:get()]
