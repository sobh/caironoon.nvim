local p = require("caironoon.palette")
local util = require("caironoon.util")
local opts = require("caironoon.config").options

local M = {}
local groups = { langs = {}, plugins = {} }

-- The builtin highlighting groups.
-- :help highlight-groups
groups.common = {
	Normal      = { fg = p.fg, bg = opts.transparent and p.none or p.bg[1] },
	Terminal    = { fg = p.fg, bg = opts.transparent and p.none or p.bg[1] },
	EndOfBuffer = { fg = opts.ending_tildes and p.bg[3] or p.bg[1], bg = opts.transparent and p.none or p.bg[1] },
	FoldColumn  = { fg = p.fg, bg = opts.transparent and p.none or p.bg[2] },
	Folded      = { fg = p.fg, bg = opts.transparent and p.none or p.bg[2] },
	SignColumn  = { fg = p.fg, bg = opts.transparent and p.none or p.bg[1] },

	ToolbarLine = { fg = p.fg },
	Cursor = { reverse = true },
	vCursor = { link = "Cursor" },
	iCursor = { link = "Cursor" },
	lCursor = { link = "Cursor" },
	CursorIM = { link = "CursoR" },
	CursorColumn = { bg = p.bg[2] },
	CursorLine = { bg = p.bg[2] },
	ColorColumn = { bg = p.bg[2] },
	CursorLineNr = { fg = p.fg },
	LineNr = { fg = p.gray },
	Conceal = { fg = p.gray, bg = p.bg[2] },

	DiffAdd    = { fg = p.none, bg = p.syntax.diff.add.bg },
	DiffChange = { fg = p.none, bg = p.syntax.diff.change.bg },
	DiffDelete = { fg = p.none, bg = p.syntax.diff.delete.bg },
	DiffText   = { fg = p.none, bg = p.syntax.diff.text.bg },

	Directory = { fg = p.blue },
	ErrorMsg = { fg = p.red, bold = true },
	WarningMsg = { fg = p.yellow, bold = true },
	MoreMsg = { fg = p.blue, bold = true },
	CurSearch = { fg = p.bg[1], bg = p.orange },
	IncSearch = { fg = p.bg[1], bg = p.orange },
	Search = { fg = p.bg[1], bg = p.bg.yellow },
	Substitute = { fg = p.bg[1], bg = p.green },
	MatchParen = { fg = p.none, bg = p.gray },
	NonText = { fg = p.gray },
	Whitespace = { fg = p.bg[2] },
	SpecialKey = { fg = p.gray },
	Pmenu = { fg = p.fg, bg = p.bg[2] },
	PmenuSbar = { fg = p.none, bg = p.bg[2] },
	PmenuSel = { fg = p.bg[1], bg = p.bg.blue },
	WildMenu = { fg = p.bg[1], bg = p.blue },
	PmenuThumb = { fg = p.none, bg = p.gray },
	Question = { fg = p.yellow },
	SpellBad = { fg = p.none, undercurl = true, sp = p.red },
	SpellCap = { fg = p.none, undercurl = true, sp = p.yellow },
	SpellLocal = { fg = p.none, undercurl = true, sp = p.blue },
	SpellRare = { fg = p.none, undercurl = true, sp = p.grape },
	StatusLine = { fg = p.fg, bg = p.bg[3] },
	StatusLineTerm = { fg = p.fg, bg = p.bg[3] },
	StatusLineNC = { fg = p.gray, bg = p.bg[2] },
	StatusLineTermNC = { fg = p.gray, bg = p.bg[2] },
	TabLine = { fg = p.fg, bg = p.bg[2] },
	TabLineFill = { fg = p.gray, bg = p.bg[2] },
	TabLineSel = { fg = p.bg[1], bg = p.fg },
	WinSeparator = { fg = p.bg[4] },
	Visual = { bg = p.bg[4] },
	VisualNOS = { fg = p.none, bg = p.bg[3], underline = true },
	QuickFixLine = { fg = p.blue, underline = true },
	Debug = { fg = p.yellow },
	debugPC = { fg = p.bg[1], bg = p.green },
	debugBreakpoint = { fg = p.bg[1], bg = p.red },
	ToolbarButton = { fg = p.bg[1], bg = p.bg.blue },
	FloatBorder = { fg = p.gray, bg = p.bg[2] },
	NormalFloat = { fg = p.fg, bg = p.bg[2] },
	Title = { fg = p.cyan },
}

-- stylua: ignore
groups.syntax = {
	-- :help group-name
	Comment      = { fg = p.syntax.comment },       -- A Comment

	Constant     = { fg = p.cyan },                 -- Any Constant
	String       = { fg = p.green },                -- A string literal "like this"
	Character    = { fg = p.orange },               -- A character constant: 'c', '\n'
	Number       = { fg = p.orange },               -- A number constant: 234, 0xff
	Boolean      = { fg = p.orange },               -- A boolean constant: TRUE, false
	Float        = { fg = p.orange },               -- A floating point constant: 2.3e10

	Identifier   = { fg = p.red },                  -- Any variable name
	Function     = { fg = p.blue, bold = true },    -- Function name

	Statement    = { fg = p.grape, italic = true }, -- Any statement
	Conditional  = { link = "Statement" },          -- if, then, else, endif, switch, etc.
	Repeat       = { link = "Statement" },          -- for, to, while, etc.
	Label        = { link = "Statement" },          -- case, default, etc.
	Operator     = { link = "Statement" },          -- "sizeof", "+", "*", etc.
	Keyword      = { link = "Statement" },          -- Any other keyword
	Exception    = { link = "Statement" },          -- try, catch, throw

	PreProc      = { fg = p.grape },                -- Generic Preprocessor
	Include      = { link = "PreProc" },            -- Preprocessor #include
	Define       = { link = "PreProc" },            -- Preprocessor #define
	Macro        = { fg = p.red },                  -- Same as Define
	PreCondit    = { link = "PreProc" },            -- Preprocessor #if, #else, #endif, etc.

	Type         = { fg = p.yellow },               -- int, long, char, etc.
	StorageClass = { link = "Type" },               -- static, register, volatile, etc.
	Structure    = { link = "Type" },               -- struct, union, enum, etc.
	Typedef      = { link = "Type" },               -- A typedef

	Special        = { fg = p.red },                   -- any special symbol
	SpecialChar    = { link = "Special" },             -- special character in a constant
	Tag            = { fg = p.green, underline=true }, -- you can use CTRL-] on this
	Delimiter      = { fg = p.light_gray },            -- character that needs attention
	SpecialComment = { fg = p.syntax.comment },        -- special things inside a comment
	Debug          = { fg = p.orange },                -- debugging statements

	Underlined = { fg = p.violet, underline = true }, -- text that stands out, HTML links

	Ignore     = { fg = p.fg },     -- left blank, hidden  |hl-Ignore|

	Error      = { fg = p.grape },  -- any erroneous construct

	Todo       = { fg = p.orange }, -- TODO, FIXME, XXX etc
}

groups.treesitter = {
	["@annotation"] = { fg = p.fg },
	["@attribute"] = { fg = p.cyan },
	["@attribute.typescript"] = { fg = p.blue },
	["@boolean"] = { fg = p.orange },
	["@character"] = { fg = p.orange },
	["@comment"] = { link = "Comment" },
	["@comment.todo"] = { link = "Todo" },
	["@comment.todo.unchecked"] = { fg = p.red },
	["@comment.todo.checked"] = { fg = p.green },
	["@constant"] = { link = "Constant" },
	["@constant.builtin"] = { link = "Constant" },
	["@constant.macro"] = { link = "Constant" },
	["@constructor"] = { fg = p.yellow, bold = true },
	["@diff.add"] = { fg = p.green },
	["@diff.delete"] = { fg = p.red },
	["@error"] = { fg = p.fg },

	["@function"] = { link = "Function" },
	["@function.builtin"] = { fg = p.cyan, bold = true },
	["@function.macro"] = { fg = p.teal },
	["@function.method"] = { fg = p.indigo },

	["@keyword"] = { link = "Keyword" },
	["@keyword.conditional"] = { link = "Keyword" },
	["@keyword.directive"] = { link = "Keyword" },
	["@keyword.exception"] = { link = "Keyword" },
	["@keyword.function"] = { link = "Keyword" },
	["@keyword.import"] = { link = "Keyword" },
	["@keyword.operator"] = { link = "Keyword" },
	["@keyword.repeat"] = { link = "Keyword" },

	["@label"] = { fg = p.red },
	["@markup.emphasis"] = { fg = p.fg, italic = true },
	["@markup.environment"] = { fg = p.fg },
	["@markup.environment.name"] = { fg = p.fg },
	["@markup.heading"] = { fg = p.orange, bold = true },
	["@markup.link"] = { fg = p.blue },
	["@markup.link.url"] = { fg = p.cyan, underline = true },
	["@markup.list"] = { fg = p.red },
	["@markup.math"] = { fg = p.fg },
	["@markup.raw"] = { fg = p.green },
	["@markup.strike"] = { fg = p.fg, strikethrough = true },
	["@markup.strong"] = { fg = p.fg, bold = true },
	["@markup.underline"] = { fg = p.fg, underline = true },
	["@module"] = { fg = p.yellow },
	["@none"] = { fg = p.fg },
	["@number"] = { fg = p.orange },
	["@number.float"] = { fg = p.orange },
	["@operator"] = { fg = p.fg },
	["@parameter.reference"] = { fg = p.fg },
	["@property"] = { fg = p.cyan },
	["@punctuation.delimiter"] = { fg = p.light_gray },
	["@punctuation.bracket"] = { fg = p.light_gray },
	["@string"] = { fg = p.green },
	["@string.regexp"] = { fg = p.orange },
	["@string.escape"] = { fg = p.red },
	["@string.special.symbol"] = { fg = p.cyan },
	["@tag"] = { fg = p.grape },
	["@tag.attribute"] = { fg = p.yellow },
	["@tag.delimiter"] = { fg = p.grape },
	["@text"] = { fg = p.fg },
	["@note"] = { fg = p.green },
	["@warning"] = { fg = p.fg },
	["@danger"] = { fg = p.fg },
	["@type"] = { fg = p.yellow },
	["@type.builtin"] = { fg = p.orange },
	["@variable"] = { fg = p.fg },
	["@variable.builtin"] = { fg = p.red },
	["@variable.member"] = { fg = p.cyan },
	["@variable.parameter"] = { fg = p.red },
	["@markup.heading.1.markdown"] = { fg = p.red, bold = true },
	["@markup.heading.2.markdown"] = { fg = p.grape, bold = true },
	["@markup.heading.3.markdown"] = { fg = p.orange, bold = true },
	["@markup.heading.4.markdown"] = { fg = p.red, bold = true },
	["@markup.heading.5.markdown"] = { fg = p.grape, bold = true },
	["@markup.heading.6.markdown"] = { fg = p.orange, bold = true },
	["@markup.heading.1.marker.markdown"] = { fg = p.red, bold = true },
	["@markup.heading.2.marker.markdown"] = { fg = p.grape, bold = true },
	["@markup.heading.3.marker.markdown"] = { fg = p.orange, bold = true },
	["@markup.heading.4.marker.markdown"] = { fg = p.red, bold = true },
	["@markup.heading.5.marker.markdown"] = { fg = p.grape, bold = true },
	["@markup.heading.6.marker.markdown"] = { fg = p.orange, bold = true },
}

groups.lsp = {
	["@lsp.type.comment"] = groups.treesitter["@comment"],
	["@lsp.type.enum"] = groups.treesitter["@type"],
	["@lsp.type.enumMember"] = groups.treesitter["@constant.builtin"],
	["@lsp.type.interface"] = groups.treesitter["@type"],
	["@lsp.type.typeParameter"] = groups.treesitter["@type"],
	["@lsp.type.keyword"] = groups.treesitter["@keyword"],
	["@lsp.type.namespace"] = groups.treesitter["@module"],
	["@lsp.type.parameter"] = groups.treesitter["@variable.parameter"],
	["@lsp.type.property"] = groups.treesitter["@property"],
	["@lsp.type.variable"] = groups.treesitter["@variable"],
	["@lsp.type.macro"] = groups.treesitter["@function.macro"],
	["@lsp.type.method"] = groups.treesitter["@function.method"],
	["@lsp.type.number"] = groups.treesitter["@number"],
	["@lsp.type.generic"] = groups.treesitter["@text"],
	["@lsp.type.builtinType"] = groups.treesitter["@type.builtin"],
	["@lsp.typemod.method.defaultLibrary"] = groups.treesitter["@function"],
	["@lsp.typemod.function.defaultLibrary"] = groups.treesitter["@function"],
	["@lsp.typemod.operator.injected"] = groups.treesitter["@operator"],
	["@lsp.typemod.string.injected"] = groups.treesitter["@string"],
	["@lsp.typemod.variable.defaultLibrary"] = groups.treesitter["@variable.builtin"],
	["@lsp.typemod.variable.injected"] = groups.treesitter["@variable"],
	["@lsp.typemod.variable.static"] = groups.treesitter["@constant"],
}

groups.diagnostics = {

	DiagnosticError = { fg=p.syntax.diag.error.fg },
	DiagnosticHint  = { fg=p.syntax.diag.hint.fg },
	DiagnosticInfo  = { fg=p.syntax.diag.info.fg },
	DiagnosticWarn  = { fg=p.syntax.diag.warning.fg },

	DiagnosticVirtualTextError = { fg=p.syntax.diag.error.fg, bg=util.darken(p.syntax.diag.error.fg, 0.1, p.bg[1]) },
	DiagnosticVirtualTextHint  = { fg=p.syntax.diag.hint.fg, bg=util.darken(p.syntax.diag.hint.fg, 0.1, p.bg[1]) },
	DiagnosticVirtualTextInfo  = { fg=p.syntax.diag.info.fg, bg=util.darken(p.syntax.diag.info.fg, 0.1, p.bg[1]) },
	DiagnosticVirtualTextWarn  = { fg=p.syntax.diag.warning.fg, bg=util.darken(p.syntax.diag.warning.fg, 0.1, p.bg[1]) },

	DiagnosticUnderlineError = { undercurl=true, sp = p.syntax.diag.error.fg },
	DiagnosticUnderlineHint  = { undercurl=true, sp = p.syntax.diag.hint.fg },
	DiagnosticUnderlineInfo  = { undercurl=true, sp = p.syntax.diag.info.fg },
	DiagnosticUnderlineWarn  = { undercurl=true, sp = p.syntax.diag.warning.fg },

}

groups.plugins = {
	-- stylua: ignore start
	lsp = {
		LspDiagnosticsDefaultError           = { link='DiagnosticError' },
		LspDiagnosticsDefaultHint            = { link='DiagnosticHint' },
		LspDiagnosticsDefaultInformation     = { link='DiagnosticInfo' },
		LspDiagnosticsDefaultWarning         = { link='DiagnosticWarn' },

		LspDiagnosticsUnderlineError         = { link='DiagnosticUnderlineError' },
		LspDiagnosticsUnderlineHint          = { link='DiagnosticUnderlineHint' },
		LspDiagnosticsUnderlineInformation   = { link='DiagnosticUnderlineInfo' },
		LspDiagnosticsUnderlineWarning       = { link='DiagnosticUnderlineWarn' },

		LspDiagnosticsVirtualTextError       = { link='DiagnosticVirtualTextError' },
		LspDiagnosticsVirtualTextWarning     = { link='DiagnosticVirtualTextWarn' },
		LspDiagnosticsVirtualTextInformation = { link='DiagnosticVirtualTextInfo' },
		LspDiagnosticsVirtualTextHint        = { link='DiagnosticVirtualTextHint' },

		LspReferenceText  = { bg = p.bg[3] },
		LspReferenceWrite = { bg = p.bg[3] },
		LspReferenceRead  = { bg = p.bg[3] },

		LspCodeLens = { fg = p.gray },
		LspCodeLensSeparator = { fg = p.gray },

		LspCxxHlGroupEnumConstant = { fg = p.orange },
		LspCxxHlGroupMemberVariable = { fg = p.orange },
		LspCxxHlGroupNamespace = { fg = p.blue },
		LspCxxHlSkippedRegion = { fg = p.gray },
		LspCxxHlSkippedRegionBeginEnd = { fg = p.red },
	},

	ale = {
		ALEErrorSign   = { link='DiagnosticError' },
		ALEInfoSign    = { link='DiagnosticInfo' },
		ALEWarningSign = { link='DiagnosticWarn' },
	},

	coc = {
		CocErrorSign   = { link='DiagnosticError' },
		CocHintSign    = { link='DiagnosticHint' },
		CocInfoSign    = { link='DiagnosticInfo' },
		CocWarningSign = { link='DiagnosticWarn' },
	},
	-- stylua: ignore end

	barbar = {
		BufferCurrent = { bold = true },
		BufferCurrentMod = { fg = p.orange, bold = true, italic = true },
		BufferCurrentSign = { fg = p.grape },
		BufferInactiveMod = { fg = p.light_gray, bg = p.bg[2], italic = true },
		BufferVisible = { fg = p.light_gray, bg = p.bg[1] },
		BufferVisibleMod = { fg = p.yellow, bg = p.bg[1], italic = true },
		BufferVisibleIndex = { fg = p.light_gray, bg = p.bg[1] },
		BufferVisibleSign = { fg = p.light_gray, bg = p.bg[1] },
		BufferVisibleTarget = { fg = p.light_gray, bg = p.bg[1] },
	},

	cmp = {
		CmpItemAbbr = { fg = p.fg },
		CmpItemAbbrDeprecated = { fg = p.light_gray, strikethrough = true },
		CmpItemAbbrMatch = { fg = p.cyan },
		CmpItemAbbrMatchFuzzy = { fg = p.cyan, underline = true },
		CmpItemMenu = { fg = p.light_gray },
		CmpItemKind = { fg = p.grape, reverse = true },
	},

	whichkey = {
		WhichKey = { fg = p.red },
		WhichKeyDesc = { fg = p.blue },
		WhichKeyGroup = { fg = p.orange },
		WhichKeySeparator = { fg = p.green },
	},

	gitgutter = {
		-- GitGutterAdd = { fg = p.green },
		-- GitGutterChange = { fg = p.blue },
		-- GitGutterDelete = { fg = p.red },
	},

	hop = {
		HopNextKey = { fg = p.red, bold = true },
		HopNextKey1 = { fg = p.cyan, bold = true },
		HopNextKey2 = { fg = util.darken(p.blue, 0.7) },
		HopUnmatched = { fg = p.gray },
	},

	diffview = {
		DiffviewFilePanelTitle = { fg = p.blue, bold = true },
		DiffviewFilePanelCounter = { fg = p.grape, bold = true },
		DiffviewFilePanelFileName = { fg = p.fg },
		DiffviewNormal = groups.common.Normal,
		DiffviewCursorLine = groups.common.CursorLine,
		DiffviewVertSplit = groups.common.VertSplit,
		DiffviewSignColumn = groups.common.SignColumn,
		DiffviewStatusLine = groups.common.StatusLine,
		DiffviewStatusLineNC = groups.common.StatusLineNC,
		DiffviewEndOfBuffer = groups.common.EndOfBuffer,
		DiffviewFilePanelRootPath = { fg = p.gray },
		DiffviewFilePanelPath = { fg = p.gray },
		DiffviewFilePanelInsertions = { fg = p.green },
		DiffviewFilePanelDeletions = { fg = p.red },
		DiffviewStatusAdded = { fg = p.green },
		DiffviewStatusUntracked = { fg = p.blue },
		DiffviewStatusModified = { fg = p.blue },
		DiffviewStatusRenamed = { fg = p.blue },
		DiffviewStatusCopied = { fg = p.blue },
		DiffviewStatusTypeChange = { fg = p.blue },
		DiffviewStatusUnmerged = { fg = p.blue },
		DiffviewStatusUnknown = { fg = p.red },
		DiffviewStatusDeleted = { fg = p.red },
		DiffviewStatusBroken = { fg = p.red },
	},

	gitsigns = {
		GitSignsAdd      = { link='DiffAdd' },
		GitSignsAddLn    = { link='DiffAdd' },
		GitSignsAddNr    = { link='DiffAdd' },
		GitSignsChange   = { link='DiffChange' },
		GitSignsChangeLn = { link='DiffChange' },
		GitSignsChangeLnInline = { link='DiffText' },
		GitSignsChangeNr = { link='DiffChange' },
		GitSignsDelete   = { link='DiffDelete' },
		GitSignsDeleteLn = { link='DiffDelete' },
		GitSignsDeleteNr = { link='DiffDelete' },
	},

	neo_tree = {
		NeoTreeNormal = { fg = p.fg, bg = opts.transparent and p.none or p.bg.dark },
		NeoTreeNormalNC = { fg = p.fg, bg = opts.transparent and p.none or p.bg.dark },
		NeoTreeVertSplit = { fg = p.bg[2], bg = opts.transparent and p.none or p.bg[2] },
		NeoTreeWinSeparator = { fg = p.bg[2], bg = opts.transparent and p.none or p.bg[2] },
		NeoTreeEndOfBuffer = { fg = opts.ending_tildes and p.bg[3] or p.bg.dark, bg = opts.transparent and p.none or p.bg.dark },
		NeoTreeRootName = { fg = p.orange, bold = true },
		NeoTreeGitAdded = { fg = p.green },
		NeoTreeGitDeleted = { fg = p.red },
		NeoTreeGitModified = { fg = p.yellow },
		NeoTreeGitConflict = { fg = p.red, bold = true, italic = true },
		NeoTreeGitUntracked = { fg = p.red, italic = true },
		NeoTreeIndentMarker = { fg = p.gray },
		NeoTreeSymbolicLinkTarget = { fg = p.grape },
	},

	neotest = {
		NeotestAdapterName = { fg = p.grape, bold = true },
		NeotestDir = { fg = p.cyan },
		NeotestExpandMarker = { fg = p.gray },
		NeotestFailed = { fg = p.red },
		NeotestFile = { fg = p.cyan },
		NeotestFocused = { bold = true, italic = true },
		NeotestIndent = { fg = p.gray },
		NeotestMarked = { fg = p.orange, bold = true },
		NeotestNamespace = { fg = p.blue },
		NeotestPassed = { fg = p.green },
		NeotestRunning = { fg = p.yellow },
		NeotestWinSelect = { fg = p.cyan, bold = true },
		NeotestSkipped = { fg = p.light_gray },
		NeotestTarget = { fg = p.grape },
		NeotestTest = { fg = p.fg },
		NeotestUnknown = { fg = p.light_gray },
	},

	nvim_tree = {
		NvimTreeNormal = { fg = p.fg, bg = opts.transparent and p.none or p.bg.dark },
		NvimTreeVertSplit = { fg = p.bg.dark, bg = opts.transparent and p.none or p.bg.dark },
		NvimTreeEndOfBuffer = { fg = opts.ending_tildes and p.bg[3] or p.bg.dark, bg = opts.transparent and p.none or p.bg.dark },
		NvimTreeRootFolder = { fg = p.orange, bold = true },
		NvimTreeGitDirty = { fg = p.yellow },
		NvimTreeGitNew = { fg = p.green },
		NvimTreeGitDeleted = { fg = p.red },
		NvimTreeSpecialFile = { fg = p.yellow, underline = true },
		NvimTreeIndentMarker = { fg = p.fg },
		NvimTreeImageFile = { fg = p.dark_purple },
		NvimTreeSymlink = { fg = p.grape },
		NvimTreeFolderName = { fg = p.blue },
	},
	telescope = {
		TelescopeBorder = { fg = p.red },
		TelescopePromptBorder = { fg = p.cyan },
		TelescopeResultsBorder = { fg = p.cyan },
		TelescopePreviewBorder = { fg = p.cyan },
		TelescopeMatching = { fg = p.orange, bold = true },
		TelescopePromptPrefix = { fg = p.green },
		TelescopeSelection = { bg = p.bg[3] },
		TelescopeSelectionCaret = { fg = p.yellow },
	},

	dashboard = {
		DashboardShortCut = { fg = p.blue },
		DashboardHeader = { fg = p.yellow },
		DashboardCenter = { fg = p.cyan },
		DashboardFooter = { fg = p.dark_red, italic = true },
	},

	outline = {
		FocusedSymbol = { fg = p.grape, bg = p.bg[3], bold = true },
		AerialLine = { fg = p.grape, bg = p.bg[3], bold = true },
	},

	navic = {
		NavicText = { fg = p.fg },
		NavicSeparator = { fg = p.light_gray },
	},

	-- stylua: ignore
	rainbow = {
		RainbowRed    = { fg = p.red },
		RainbowOrange = { fg = p.orange },
		RainbowYellow = { fg = p.yellow },
		RainbowLime   = { fg = p.lime },
		RainbowGreen  = { fg = p.green },
		RainbowTeal   = { fg = p.teal },
		RainbowCyan   = { fg = p.cyan },
		RainbowBlue   = { fg = p.blue },
		RainbowIndigo = { fg = p.indigo },
		RainbowViolet = { fg = p.violet },
		RainbowGrape  = { fg = p.Grape },
		RainbowPink   = { fg = p.violet },
	},

	ts_rainbow = {
		rainbowcol1 = { fg = p.light_gray },
		rainbowcol2 = { fg = p.yellow },
		rainbowcol3 = { fg = p.blue },
		rainbowcol4 = { fg = p.orange },
		rainbowcol5 = { fg = p.grape },
		rainbowcol6 = { fg = p.green },
		rainbowcol7 = { fg = p.red },
	},

	ts_rainbow2 = {
		TSRainbowRed = { fg = p.red },
		TSRainbowYellow = { fg = p.yellow },
		TSRainbowBlue = { fg = p.blue },
		TSRainbowOrange = { fg = p.orange },
		TSRainbowGreen = { fg = p.green },
		TSRainbowViolet = { fg = p.grape },
		TSRainbowCyan = { fg = p.cyan },
	},

	rainbow_delimiters = {
		RainbowDelimiterRed = { fg = p.red },
		RainbowDelimiterYellow = { fg = p.yellow },
		RainbowDelimiterBlue = { fg = p.blue },
		RainbowDelimiterOrange = { fg = p.orange },
		RainbowDelimiterGreen = { fg = p.green },
		RainbowDelimiterViolet = { fg = p.grape },
		RainbowDelimiterCyan = { fg = p.cyan },
	},

	indent_blankline = {
		IndentBlanklineIndent1 = { fg = p.blue },
		IndentBlanklineIndent2 = { fg = p.green },
		IndentBlanklineIndent3 = { fg = p.cyan },
		IndentBlanklineIndent4 = { fg = p.light_gray },
		IndentBlanklineIndent5 = { fg = p.grape },
		IndentBlanklineIndent6 = { fg = p.red },
		IndentBlanklineChar = { fg = p.bg[2], nocombine = true },
		IndentBlanklineContextChar = { fg = p.gray, nocombine = true },
		IndentBlanklineContextStart = { sp = p.gray, underline = true },
		IndentBlanklineContextSpaceChar = { nocombine = true },

		-- Ibl v3
		IblIndent = { fg = p.bg[2], nocombine = true },
		IblWhitespace = { fg = p.gray, nocombine = true },
		IblScope = { fg = p.gray, nocombine = true },
	},

	mini = {
		MiniCompletionActiveParameter = { underline = true },

		MiniCursorword = { underline = true },
		MiniCursorwordCurrent = { underline = true },

		MiniIndentscopeSymbol = { fg = p.gray },
		MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible

		MiniJump = { fg = p.grape, underline = true, sp = p.grape },

		MiniJump2dSpot = { fg = p.red, bold = true, nocombine = true },

		MiniStarterCurrent = { nocombine = true },
		MiniStarterFooter = { fg = p.dark_red, italic = true },
		MiniStarterHeader = { fg = p.yellow },
		MiniStarterInactive = { fg = p.gray },
		MiniStarterItem = { fg = p.fg, bg = opts.transparent and p.none or p.bg[1] },
		MiniStarterItemBullet = { fg = p.gray },
		MiniStarterItemPrefix = { fg = p.yellow },
		MiniStarterSection = { fg = p.light_gray },
		MiniStarterQuery = { fg = p.cyan },

		MiniStatuslineDevinfo = { fg = p.fg, bg = p.bg[3] },
		MiniStatuslineFileinfo = { fg = p.fg, bg = p.bg[3] },
		MiniStatuslineFilename = { fg = p.gray, bg = p.bg[2] },
		MiniStatuslineInactive = { fg = p.gray, bg = p.bg[1] },
		MiniStatuslineModeCommand = { fg = p.bg[1], bg = p.yellow, bold = true },
		MiniStatuslineModeInsert = { fg = p.bg[1], bg = p.blue, bold = true },
		MiniStatuslineModeNormal = { fg = p.bg[1], bg = p.green, bold = true },
		MiniStatuslineModeOther = { fg = p.bg[1], bg = p.cyan, bold = true },
		MiniStatuslineModeReplace = { fg = p.bg[1], bg = p.red, bold = true },
		MiniStatuslineModeVisual = { fg = p.bg[1], bg = p.grape, bold = true },

		MiniSurround = { fg = p.bg[1], bg = p.orange },

		MiniTablineCurrent = { bold = true },
		MiniTablineFill = { fg = p.gray, bg = p.bg[2] },
		MiniTablineHidden = { fg = p.fg, bg = p.bg[2] },
		MiniTablineModifiedCurrent = { fg = p.orange, bold = true, italic = true },
		MiniTablineModifiedHidden = { fg = p.light_gray, bg = p.bg[2], italic = true },
		MiniTablineModifiedVisible = { fg = p.yellow, bg = p.bg[1], italic = true },
		MiniTablineTabpagesection = { fg = p.bg[1], bg = p.bg.yellow },
		MiniTablineVisible = { fg = p.light_gray, bg = p.bg[1] },

		MiniTestEmphasis = { bold = true },
		MiniTestFail = { fg = p.red, bold = true },
		MiniTestPass = { fg = p.green, bold = true },

		MiniTrailspace = { bg = p.red },
	},

}

groups.langs = {

	c = {
		cInclude = { fg = p.blue },
		cStorageClass = { fg = p.grape },
		cTypedef = { fg = p.grape },
		cDefine = { fg = p.cyan },
		cTSInclude = { fg = p.blue },
		cTSConstant = { fg = p.cyan },
		cTSConstMacro = { fg = p.grape },
		cTSOperator = { fg = p.grape },
	},

	cpp = {
		cppStatement = { fg = p.grape, bold = true },
		cppTSInclude = { fg = p.blue },
		cppTSConstant = { fg = p.cyan },
		cppTSConstMacro = { fg = p.grape },
		cppTSOperator = { fg = p.grape },
	},

	diff = {
		diffFile    = { fg = p.pink },
		diffLine    = { fg = p.grape, bold = true },
		diffOldFile = { fg = p.yellow },
		diffNewFile = { fg = p.cyan },
		diffAdded   = { fg = p.syntax.diff.add.fg, bg = p.syntax.diff.add.bg },
		diffRemoved = { fg = p.syntax.diff.delete.fg, bg = p.syntax.diff.delete.bg },
	},

	markdown = {
		markdownBlockquote = { fg = p.gray },
		markdownBold = { fg = p.none, bold = true },
		markdownBoldDelimiter = { fg = p.gray },
		markdownCode = { fg = p.green },
		markdownCodeBlock = { fg = p.green },
		markdownCodeDelimiter = { fg = p.yellow },
		markdownH1 = { fg = p.red, bold = true },
		markdownH2 = { fg = p.grape, bold = true },
		markdownH3 = { fg = p.orange, bold = true },
		markdownH4 = { fg = p.red, bold = true },
		markdownH5 = { fg = p.grape, bold = true },
		markdownH6 = { fg = p.orange, bold = true },
		markdownHeadingDelimiter = { fg = p.gray },
		markdownHeadingRule = { fg = p.gray },
		markdownId = { fg = p.yellow },
		markdownIdDeclaration = { fg = p.red },
		markdownItalic = { fg = p.none, italic = true },
		markdownItalicDelimiter = { fg = p.gray, italic = true },
		markdownLinkDelimiter = { fg = p.gray },
		markdownLinkText = { fg = p.red },
		markdownLinkTextDelimiter = { fg = p.gray },
		markdownListMarker = { fg = p.red },
		markdownOrderedListMarker = { fg = p.red },
		markdownRule = { fg = p.grape },
		markdownUrl = { fg = p.blue, underline = true },
		markdownUrlDelimiter = { fg = p.gray },
		markdownUrlTitleDelimiter = { fg = p.green },
	},

	php = {
		phpFunctions = { fg = p.fg },
		phpMethods = { fg = p.cyan },
		phpStructure = { fg = p.grape },
		phpOperator = { fg = p.grape },
		phpMemberSelector = { fg = p.fg },
		phpVarSelector = { fg = p.orange },
		phpIdentifier = { fg = p.orange },
		phpBoolean = { fg = p.cyan },
		phpNumber = { fg = p.orange },
		phpHereDoc = { fg = p.green },
		phpNowDoc = { fg = p.green },
		phpSCKeyword = { fg = p.grape },
		phpFCKeyword = { fg = p.grape },
		phpRegion = { fg = p.blue },
	},

	scala = {
		scalaNameDefinition = { fg = p.fg },
		scalaInterpolationBoundary = { fg = p.grape },
		scalaInterpolation = { fg = p.grape },
		scalaTypeOperator = { fg = p.red },
		scalaOperator = { fg = p.red },
		scalaKeywordModifier = { fg = p.red },
	},

	tex = {
		latexTSInclude = { fg = p.blue },
		latexTSFuncMacro = { fg = p.fg },
		latexTSEnvironment = { fg = p.cyan, bold = true },
		latexTSEnvironmentName = { fg = p.yellow },
		texCmdEnv = { fg = p.cyan },
		texEnvArgName = { fg = p.yellow },
		latexTSTitle = { fg = p.green },
		latexTSType = { fg = p.blue },
		latexTSMath = { fg = p.orange },
		texMathZoneX = { fg = p.orange },
		texMathZoneXX = { fg = p.orange },
		texMathDelimZone = { fg = p.light_gray },
		texMathDelim = { fg = p.grape },
		texMathOper = { fg = p.red },
		texCmd = { fg = p.grape },
		texCmdPart = { fg = p.blue },
		texCmdPackage = { fg = p.blue },
		texPgfType = { fg = p.yellow },
	},

	vim = {
		vimOption = { fg = p.red },
		vimSetEqual = { fg = p.yellow },
		vimMap = { fg = p.grape },
		vimMapModKey = { fg = p.orange },
		vimNotation = { fg = p.red },
		vimMapLhs = { fg = p.fg },
		vimMapRhs = { fg = p.blue },
		vimVar = { fg = p.fg },
		vimCommentTitle = { fg = p.light_gray },
	},
}

local lsp_kind_icons_color = {
	Default = p.grape,
	Array = p.yellow,
	Boolean = p.orange,
	Class = p.yellow,
	Color = p.green,
	Constant = p.orange,
	Constructor = p.blue,
	Enum = p.grape,
	EnumMember = p.yellow,
	Event = p.yellow,
	Field = p.grape,
	File = p.blue,
	Folder = p.orange,
	Function = p.blue,
	Interface = p.green,
	Key = p.cyan,
	Keyword = p.cyan,
	Method = p.blue,
	Module = p.orange,
	Namespace = p.red,
	Null = p.gray,
	Number = p.orange,
	Object = p.red,
	Operator = p.red,
	Package = p.yellow,
	Property = p.cyan,
	Reference = p.orange,
	Snippet = p.red,
	String = p.green,
	Struct = p.grape,
	Text = p.light_gray,
	TypeParameter = p.red,
	Unit = p.green,
	Value = p.orange,
	Variable = p.grape,
}

local function highlight_group(highlights)
	for group_name, group_settings in pairs(highlights) do
		vim.api.nvim_set_hl(0, group_name, group_settings)
	end
end

function M.setup()
	-- define cmp and aerial kind highlights with lsp_kind_icons_color
	for kind, color in pairs(lsp_kind_icons_color) do
		groups.plugins.cmp["CmpItemKind" .. kind] = { fg = color, reverse=true}
		groups.plugins.outline["Aerial" .. kind .. "Icon"] = { fg = color }
		groups.plugins.navic["NavicIcons" .. kind] = { fg = color }
	end

	highlight_group(groups.common)
	highlight_group(groups.syntax)
	highlight_group(groups.treesitter)
	highlight_group(groups.lsp)
	highlight_group(groups.diagnostics)
	for _, group in pairs(groups.langs) do
		highlight_group(group)
	end
	for _, group in pairs(groups.plugins) do
		highlight_group(group)
	end
end

return M
