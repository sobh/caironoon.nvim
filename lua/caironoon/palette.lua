local s = require("caironoon.swatches")

local idx = {
	light = {
		fg = 10;
		bg = 1;
	},
	dark = {
		fg = 3;
		bg = 7;
	}
}

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

local gui = {

	dark = {

		fg = {
			base = s.gray[3],

			gray   = s.gray[idx.dark.fg],
			red    = s.red[idx.dark.fg],
			orange = s.orange[idx.dark.fg],
			yellow = s.yellow[idx.dark.fg],
			lime   = s.lime[idx.dark.fg],
			green  = s.green[idx.dark.fg],
			teal   = s.teal[idx.dark.fg],
			cyan   = s.cyan[idx.dark.fg],
			blue   = s.blue[idx.dark.fg],
			indigo = s.indigo[idx.dark.fg],
			purple = s.purple[idx.dark.fg],
			violet = s.violet[idx.dark.fg],
			pink   = s.pink[idx.dark.fg],
		},

		bg = {
			base = {
				s.gray[10],
				s.gray[9],
				s.gray[8],
				s.gray[7],
			},

			gray   = s.gray[idx.dark.bg],
			red    = s.red[idx.dark.bg],
			orange = s.orange[idx.dark.bg],
			yellow = s.yellow[idx.dark.bg],
			lime   = s.lime[idx.dark.bg],
			green  = s.green[idx.dark.bg],
			teal   = s.teal[idx.dark.bg],
			cyan   = s.cyan[idx.dark.bg],
			blue   = s.blue[idx.dark.bg],
			indigo = s.indigo[idx.dark.bg],
			purple = s.purple[idx.dark.bg],
			violet = s.violet[idx.dark.bg],
			pink   = s.pink[idx.dark.bg],
		},

		syntax = {
			comment = s.gray[idx.dark.fg],

			diff = {
				add    = {
					fg = s.green[idx.dark.fg],
					bg = s.green[idx.dark.bg],
				},
				delete = {
					fg = s.red[idx.dark.fg],
					bg = s.red[idx.dark.bg],
				},
				change = {
					fg = s.blue[idx.dark.fg],
					bg = s.blue[idx.dark.bg],
				},
				text   = {
					fg = s.gray[idx.dark.fg],
					bg = s.gray[idx.dark.bg],
				},
			},

			diag = {
				error   = {
					fg = s.red[idx.dark.fg],
					bg = s.red[idx.dark.bg],
				},
				warning = {
					fg = s.yellow[idx.dark.fg],
					bg = s.yellow[idx.dark.bg],
				},
				info    = {
					fg = s.cyan[idx.dark.fg],
					bg = s.cyan[idx.dark.bg],
				},
				hint    = {
					fg = s.violet[idx.dark.fg],
					bg = s.violet[idx.dark.bg],
				},
			},
		},

	},

	light = {
		fg = {
			base = s.black,

			gray   = s.gray[idx.light.fg],
			red    = s.red[idx.light.fg],
			orange = s.orange[idx.light.fg],
			yellow = s.yellow[idx.light.fg],
			lime   = s.lime[idx.light.fg],
			green  = s.green[idx.light.fg],
			teal   = s.teal[idx.light.fg],
			cyan   = s.cyan[idx.light.fg],
			blue   = s.blue[idx.light.fg],
			indigo = s.indigo[idx.light.fg],
			purple = s.purple[idx.light.fg],
			violet = s.violet[idx.light.fg],
			pink   = s.pink[idx.light.fg],
		},

		bg = {
			base = {
				s.white,
				s.gray[2],
				s.gray[3],
				s.gray[4],
			},

			gray   = s.gray[idx.light.bg],
			red    = s.red[idx.light.bg],
			orange = s.orange[idx.light.bg],
			yellow = s.yellow[idx.light.bg],
			lime   = s.lime[idx.light.bg],
			green  = s.green[idx.light.bg],
			teal   = s.teal[idx.light.bg],
			cyan   = s.cyan[idx.light.bg],
			blue   = s.blue[idx.light.bg],
			indigo = s.indigo[idx.light.bg],
			purple = s.purple[idx.light.bg],
			violet = s.violet[idx.light.bg],
			pink   = s.pink[idx.light.bg],
		},
		-- Comment
		syntax = {
			comment = s.gray[idx.light.fg - 2],

			diff = {
				add    = {
					fg = s.green[idx.light.fg],
					bg = s.green[idx.light.bg],
				},
				delete = {
					fg = s.red[idx.light.fg],
					bg = s.red[idx.light.bg],
				},
				change = {
					fg = s.blue[idx.light.fg],
					bg = s.blue[idx.light.bg],
				},
				text   = {
					fg = s.gray[idx.light.fg],
					bg = s.gray[idx.light.bg],
				},
			},

			diag = {
				error   = {
					fg = s.red[idx.light.fg],
					bg = s.red[idx.light.bg],
				},
				warning = {
					fg = s.yellow[idx.light.fg],
					bg = s.yellow[idx.light.bg],
				},
				info    = {
					fg = s.cyan[idx.light.fg],
					bg = s.cyan[idx.light.bg],
				},
				hint    = {
					fg = s.violet[idx.light.fg],
					bg = s.violet[idx.light.bg],
				},
			},
		}

	},

}
local palette = gui[vim.opt.background:get()]
palette.term = term[vim.opt.background:get()]
palette.none = "none"
palette.white = "#FFFFFF"
palette.black = "#000000"

return palette
