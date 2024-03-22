local p = require("caironoon.palette")
local cfg = vim.g.caironoon_config
local util = require("caironoon.util")

local M = {}
local hl = { langs = {}, plugins = {} }

local function vim_highlights(highlights)
	for group_name, group_settings in pairs(highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
				group_name,
				group_settings.fg or "none",
				group_settings.bg or "none",
				group_settings.sp or "none",
				group_settings.fmt or "none"
			)
		)
	end
end

local colors = {
	Fg = { fg = p.fg },
	LightGrey = { fg = p.light_grey },
	Grey = { fg = p.grey },
	Red = { fg = p.red },
	Cyan = { fg = p.cyan },
	Yellow = { fg = p.yellow },
	Orange = { fg = p.orange },
	Green = { fg = p.green },
	Blue = { fg = p.blue },
	Purple = { fg = p.grape },
}
hl.common = {
	Normal = { fg = p.fg, bg = cfg.transparent and p.none or p.bg0 },
	Terminal = { fg = p.fg, bg = cfg.transparent and p.none or p.bg0 },
	EndOfBuffer = { fg = cfg.ending_tildes and p.bg2 or p.bg0, bg = cfg.transparent and p.none or p.bg0 },
	FoldColumn = { fg = p.fg, bg = cfg.transparent and p.none or p.bg1 },
	Folded = { fg = p.fg, bg = cfg.transparent and p.none or p.bg1 },
	SignColumn = { fg = p.fg, bg = cfg.transparent and p.none or p.bg0 },
	ToolbarLine = { fg = p.fg },
	Cursor = { fmt = "reverse" },
	vCursor = { fmt = "reverse" },
	iCursor = { fmt = "reverse" },
	lCursor = { fmt = "reverse" },
	CursorIM = { fmt = "reverse" },
	CursorColumn = { bg = p.bg1 },
	CursorLine = { bg = p.bg1 },
	ColorColumn = { bg = p.bg1 },
	CursorLineNr = { fg = p.fg },
	LineNr = { fg = p.grey },
	Conceal = { fg = p.grey, bg = p.bg1 },
	DiffAdd = { fg = p.none, bg = p.diff_add },
	DiffChange = { fg = p.none, bg = p.diff_change },
	DiffDelete = { fg = p.none, bg = p.diff_delete },
	DiffText = { fg = p.none, bg = p.diff_text },
	DiffAdded = colors.Green,
	DiffRemoved = colors.Red,
	DiffFile = colors.Cyan,
	DiffIndexLine = colors.Grey,
	Directory = { fg = p.blue },
	ErrorMsg = { fg = p.red, fmt = "bold" },
	WarningMsg = { fg = p.yellow, fmt = "bold" },
	MoreMsg = { fg = p.blue, fmt = "bold" },
	CurSearch = { fg = p.bg0, bg = p.orange },
	IncSearch = { fg = p.bg0, bg = p.orange },
	Search = { fg = p.bg0, bg = p.bg_yellow },
	Substitute = { fg = p.bg0, bg = p.green },
	MatchParen = { fg = p.none, bg = p.grey },
	NonText = { fg = p.grey },
	Whitespace = { fg = p.grey },
	SpecialKey = { fg = p.grey },
	Pmenu = { fg = p.fg, bg = p.bg1 },
	PmenuSbar = { fg = p.none, bg = p.bg1 },
	PmenuSel = { fg = p.bg0, bg = p.bg_blue },
	WildMenu = { fg = p.bg0, bg = p.blue },
	PmenuThumb = { fg = p.none, bg = p.grey },
	Question = { fg = p.yellow },
	SpellBad = { fg = p.none, fmt = "undercurl", sp = p.red },
	SpellCap = { fg = p.none, fmt = "undercurl", sp = p.yellow },
	SpellLocal = { fg = p.none, fmt = "undercurl", sp = p.blue },
	SpellRare = { fg = p.none, fmt = "undercurl", sp = p.grape },
	StatusLine = { fg = p.fg, bg = p.bg2 },
	StatusLineTerm = { fg = p.fg, bg = p.bg2 },
	StatusLineNC = { fg = p.grey, bg = p.bg1 },
	StatusLineTermNC = { fg = p.grey, bg = p.bg1 },
	TabLine = { fg = p.fg, bg = p.bg1 },
	TabLineFill = { fg = p.grey, bg = p.bg1 },
	TabLineSel = { fg = p.bg0, bg = p.fg },
	WinSeparator = { fg = p.bg3 },
	Visual = { bg = p.bg3 },
	VisualNOS = { fg = p.none, bg = p.bg2, fmt = "underline" },
	QuickFixLine = { fg = p.blue, fmt = "underline" },
	Debug = { fg = p.yellow },
	debugPC = { fg = p.bg0, bg = p.green },
	debugBreakpoint = { fg = p.bg0, bg = p.red },
	ToolbarButton = { fg = p.bg0, bg = p.bg_blue },
	FloatBorder = { fg = p.grey, bg = p.bg1 },
	NormalFloat = { fg = p.fg, bg = p.bg1 },
}

hl.syntax = {
	String = { fg = p.green, fmt = cfg.code_style.strings },
	Character = colors.Orange,
	Number = colors.Orange,
	Float = colors.Orange,
	Boolean = colors.Orange,
	Type = colors.Yellow,
	Structure = colors.Yellow,
	StorageClass = colors.Yellow,
	Identifier = { fg = p.red, fmt = cfg.code_style.variables },
	Constant = colors.Cyan,
	PreProc = colors.Purple,
	PreCondit = colors.Purple,
	Include = colors.Purple,
	Keyword = { fg = p.grape, fmt = cfg.code_style.keywords },
	Define = colors.Purple,
	Typedef = colors.Yellow,
	Exception = colors.Purple,
	Conditional = { fg = p.grape, fmt = cfg.code_style.keywords },
	Repeat = { fg = p.grape, fmt = cfg.code_style.keywords },
	Statement = colors.Purple,
	Macro = colors.Red,
	Error = colors.Purple,
	Label = colors.Purple,
	Special = colors.Red,
	SpecialChar = colors.Red,
	Function = { fg = p.blue, fmt = cfg.code_style.functions },
	Operator = colors.Purple,
	Title = colors.Cyan,
	Tag = colors.Green,
	Delimiter = colors.LightGrey,
	Comment = { fg = p.grey, fmt = cfg.code_style.comments },
	SpecialComment = { fg = p.grey, fmt = cfg.code_style.comments },
	Todo = { fg = p.red, fmt = cfg.code_style.comments },
}

if vim.api.nvim_call_function("has", { "nvim-0.8" }) == 1 then
	hl.treesitter = {
		-- nvim-treesitter@0.9.2 and after
		["@annotation"] = colors.Fg,
		["@attribute"] = colors.Cyan,
		["@attribute.typescript"] = colors.Blue,
		["@boolean"] = colors.Orange,
		["@character"] = colors.Orange,
		["@comment"] = { fg = p.grey, fmt = cfg.code_style.comments },
		["@comment.todo"] = { fg = p.red, fmt = cfg.code_style.comments },
		["@comment.todo.unchecked"] = { fg = p.red, fmt = cfg.code_style.comments },
		["@comment.todo.checked"] = { fg = p.green, fmt = cfg.code_style.comments },
		["@constant"] = { fg = p.orange, fmt = cfg.code_style.constants },
		["@constant.builtin"] = { fg = p.orange, fmt = cfg.code_style.constants },
		["@constant.macro"] = { fg = p.orange, fmt = cfg.code_style.constants },
		["@constructor"] = { fg = p.yellow, fmt = "bold" },
		["@diff.add"] = colors.Green,
		["@diff.delete"] = colors.Red,
		["@error"] = colors.Fg,
		["@function"] = { fg = p.blue, fmt = cfg.code_style.functions },
		["@function.builtin"] = { fg = p.cyan, fmt = cfg.code_style.functions },
		["@function.macro"] = { fg = p.cyan, fmt = cfg.code_style.functions },
		["@function.method"] = { fg = p.blue, fmt = cfg.code_style.functions },
		["@keyword"] = { fg = p.grape, fmt = cfg.code_style.keywords },
		["@keyword.conditional"] = { fg = p.grape, fmt = cfg.code_style.keywords },
		["@keyword.directive"] = colors.Purple,
		["@keyword.exception"] = colors.Purple,
		["@keyword.function"] = { fg = p.grape, fmt = cfg.code_style.functions },
		["@keyword.import"] = colors.Purple,
		["@keyword.operator"] = { fg = p.grape, fmt = cfg.code_style.keywords },
		["@keyword.repeat"] = { fg = p.grape, fmt = cfg.code_style.keywords },
		["@label"] = colors.Red,
		["@markup.emphasis"] = { fg = p.fg, fmt = "italic" },
		["@markup.environment"] = colors.Fg,
		["@markup.environment.name"] = colors.Fg,
		["@markup.heading"] = { fg = p.orange, fmt = "bold" },
		["@markup.link"] = colors.Blue,
		["@markup.link.url"] = { fg = p.cyan, fmt = "underline" },
		["@markup.list"] = colors.Red,
		["@markup.math"] = colors.Fg,
		["@markup.raw"] = colors.Green,
		["@markup.strike"] = { fg = p.fg, fmt = "strikethrough" },
		["@markup.strong"] = { fg = p.fg, fmt = "bold" },
		["@markup.underline"] = { fg = p.fg, fmt = "underline" },
		["@module"] = colors.Yellow,
		["@none"] = colors.Fg,
		["@number"] = colors.Orange,
		["@number.float"] = colors.Orange,
		["@operator"] = colors.Fg,
		["@parameter.reference"] = colors.Fg,
		["@property"] = colors.Cyan,
		["@punctuation.delimiter"] = colors.LightGrey,
		["@punctuation.bracket"] = colors.LightGrey,
		["@string"] = { fg = p.green, fmt = cfg.code_style.strings },
		["@string.regexp"] = { fg = p.orange, fmt = cfg.code_style.strings },
		["@string.escape"] = { fg = p.red, fmt = cfg.code_style.strings },
		["@string.special.symbol"] = colors.Cyan,
		["@tag"] = colors.Purple,
		["@tag.attribute"] = colors.Yellow,
		["@tag.delimiter"] = colors.Purple,
		["@text"] = colors.Fg,
		["@note"] = colors.Fg,
		["@warning"] = colors.Fg,
		["@danger"] = colors.Fg,
		["@type"] = colors.Yellow,
		["@type.builtin"] = colors.Orange,
		["@variable"] = { fg = p.fg, fmt = cfg.code_style.variables },
		["@variable.builtin"] = { fg = p.red, fmt = cfg.code_style.variables },
		["@variable.member"] = colors.Cyan,
		["@variable.parameter"] = colors.Red,
		["@markup.heading.1.markdown"] = { fg = p.red, fmt = "bold" },
		["@markup.heading.2.markdown"] = { fg = p.grape, fmt = "bold" },
		["@markup.heading.3.markdown"] = { fg = p.orange, fmt = "bold" },
		["@markup.heading.4.markdown"] = { fg = p.red, fmt = "bold" },
		["@markup.heading.5.markdown"] = { fg = p.grape, fmt = "bold" },
		["@markup.heading.6.markdown"] = { fg = p.orange, fmt = "bold" },
		["@markup.heading.1.marker.markdown"] = { fg = p.red, fmt = "bold" },
		["@markup.heading.2.marker.markdown"] = { fg = p.grape, fmt = "bold" },
		["@markup.heading.3.marker.markdown"] = { fg = p.orange, fmt = "bold" },
		["@markup.heading.4.marker.markdown"] = { fg = p.red, fmt = "bold" },
		["@markup.heading.5.marker.markdown"] = { fg = p.grape, fmt = "bold" },
		["@markup.heading.6.marker.markdown"] = { fg = p.orange, fmt = "bold" },

		-- Old configuration for nvim-treesiter@0.9.1 and below
		["@conditional"] = { fg = p.grape, fmt = cfg.code_style.keywords },
		["@exception"] = colors.Purple,
		["@field"] = colors.Cyan,
		["@float"] = colors.Orange,
		["@include"] = colors.Purple,
		["@method"] = { fg = p.blue, fmt = cfg.code_style.functions },
		["@namespace"] = colors.Yellow,
		["@parameter"] = colors.Red,
		["@preproc"] = colors.Purple,
		["@punctuation.special"] = colors.Red,
		["@repeat"] = { fg = p.grape, fmt = cfg.code_style.keywords },
		["@string.regex"] = { fg = p.orange, fmt = cfg.code_style.strings },
		["@text.strong"] = { fg = p.fg, fmt = "bold" },
		["@text.emphasis"] = { fg = p.fg, fmt = "italic" },
		["@text.underline"] = { fg = p.fg, fmt = "underline" },
		["@text.strike"] = { fg = p.fg, fmt = "strikethrough" },
		["@text.title"] = { fg = p.orange, fmt = "bold" },
		["@text.literal"] = colors.Green,
		["@text.uri"] = { fg = p.cyan, fmt = "underline" },
		["@text.todo"] = { fg = p.red, fmt = cfg.code_style.comments },
		["@text.todo.unchecked"] = { fg = p.red, fmt = cfg.code_style.comments },
		["@text.todo.checked"] = { fg = p.green, fmt = cfg.code_style.comments },
		["@text.math"] = colors.Fg,
		["@text.reference"] = colors.Blue,
		["@text.environment"] = colors.Fg,
		["@text.environment.name"] = colors.Fg,
		["@text.diff.add"] = colors.Green,
		["@text.diff.delete"] = colors.Red,
	}
	if vim.api.nvim_call_function("has", { "nvim-0.9" }) == 1 then
		hl.lsp = {
			["@lsp.type.comment"] = hl.treesitter["@comment"],
			["@lsp.type.enum"] = hl.treesitter["@type"],
			["@lsp.type.enumMember"] = hl.treesitter["@constant.builtin"],
			["@lsp.type.interface"] = hl.treesitter["@type"],
			["@lsp.type.typeParameter"] = hl.treesitter["@type"],
			["@lsp.type.keyword"] = hl.treesitter["@keyword"],
			["@lsp.type.namespace"] = hl.treesitter["@module"],
			["@lsp.type.parameter"] = hl.treesitter["@variable.parameter"],
			["@lsp.type.property"] = hl.treesitter["@property"],
			["@lsp.type.variable"] = hl.treesitter["@variable"],
			["@lsp.type.macro"] = hl.treesitter["@function.macro"],
			["@lsp.type.method"] = hl.treesitter["@function.method"],
			["@lsp.type.number"] = hl.treesitter["@number"],
			["@lsp.type.generic"] = hl.treesitter["@text"],
			["@lsp.type.builtinType"] = hl.treesitter["@type.builtin"],
			["@lsp.typemod.method.defaultLibrary"] = hl.treesitter["@function"],
			["@lsp.typemod.function.defaultLibrary"] = hl.treesitter["@function"],
			["@lsp.typemod.operator.injected"] = hl.treesitter["@operator"],
			["@lsp.typemod.string.injected"] = hl.treesitter["@string"],
			["@lsp.typemod.variable.defaultLibrary"] = hl.treesitter["@variable.builtin"],
			["@lsp.typemod.variable.injected"] = hl.treesitter["@variable"],
			["@lsp.typemod.variable.static"] = hl.treesitter["@constant"],
		}
	end
else
	hl.treesitter = {
		TSAnnotation = colors.Fg,
		TSAttribute = colors.Cyan,
		TSBoolean = colors.Orange,
		TSCharacter = colors.Orange,
		TSComment = { fg = p.grey, fmt = cfg.code_style.comments },
		TSConditional = { fg = p.grape, fmt = cfg.code_style.keywords },
		TSConstant = colors.Orange,
		TSConstBuiltin = colors.Orange,
		TSConstMacro = colors.Orange,
		TSConstructor = { fg = p.yellow, fmt = "bold" },
		TSError = colors.Fg,
		TSException = colors.Purple,
		TSField = colors.Cyan,
		TSFloat = colors.Orange,
		TSFunction = { fg = p.blue, fmt = cfg.code_style.functions },
		TSFuncBuiltin = { fg = p.cyan, fmt = cfg.code_style.functions },
		TSFuncMacro = { fg = p.cyan, fmt = cfg.code_style.functions },
		TSInclude = colors.Purple,
		TSKeyword = { fg = p.grape, fmt = cfg.code_style.keywords },
		TSKeywordFunction = { fg = p.grape, fmt = cfg.code_style.functions },
		TSKeywordOperator = { fg = p.grape, fmt = cfg.code_style.keywords },
		TSLabel = colors.Red,
		TSMethod = { fg = p.blue, fmt = cfg.code_style.functions },
		TSNamespace = colors.Yellow,
		TSNone = colors.Fg,
		TSNumber = colors.Orange,
		TSOperator = colors.Fg,
		TSParameter = colors.Red,
		TSParameterReference = colors.Fg,
		TSProperty = colors.Cyan,
		TSPunctDelimiter = colors.LightGrey,
		TSPunctBracket = colors.LightGrey,
		TSPunctSpecial = colors.Red,
		TSRepeat = { fg = p.grape, fmt = cfg.code_style.keywords },
		TSString = { fg = p.green, fmt = cfg.code_style.strings },
		TSStringRegex = { fg = p.orange, fmt = cfg.code_style.strings },
		TSStringEscape = { fg = p.red, fmt = cfg.code_style.strings },
		TSSymbol = colors.Cyan,
		TSTag = colors.Purple,
		TSTagDelimiter = colors.Purple,
		TSText = colors.Fg,
		TSStrong = { fg = p.fg, fmt = "bold" },
		TSEmphasis = { fg = p.fg, fmt = "italic" },
		TSUnderline = { fg = p.fg, fmt = "underline" },
		TSStrike = { fg = p.fg, fmt = "strikethrough" },
		TSTitle = { fg = p.orange, fmt = "bold" },
		TSLiteral = colors.Green,
		TSURI = { fg = p.cyan, fmt = "underline" },
		TSMath = colors.Fg,
		TSTextReference = colors.Blue,
		TSEnvironment = colors.Fg,
		TSEnvironmentName = colors.Fg,
		TSNote = colors.Fg,
		TSWarning = colors.Fg,
		TSDanger = colors.Fg,
		TSType = colors.Yellow,
		TSTypeBuiltin = colors.Orange,
		TSVariable = { fg = p.fg, fmt = cfg.code_style.variables },
		TSVariableBuiltin = { fg = p.red, fmt = cfg.code_style.variables },
	}
end

local diagnostics_error_color = cfg.diagnostics.darker and p.dark_red or p.red
local diagnostics_hint_color = cfg.diagnostics.darker and p.dark_purple or p.grape
local diagnostics_warn_color = cfg.diagnostics.darker and p.dark_yellow or p.yellow
local diagnostics_info_color = cfg.diagnostics.darker and p.dark_cyan or p.cyan
hl.plugins.lsp = {
	LspCxxHlGroupEnumConstant = colors.Orange,
	LspCxxHlGroupMemberVariable = colors.Orange,
	LspCxxHlGroupNamespace = colors.Blue,
	LspCxxHlSkippedRegion = colors.Grey,
	LspCxxHlSkippedRegionBeginEnd = colors.Red,

	DiagnosticError = { fg = p.red },
	DiagnosticHint = { fg = p.grape },
	DiagnosticInfo = { fg = p.cyan },
	DiagnosticWarn = { fg = p.yellow },

	DiagnosticVirtualTextError = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_error_color, 0.1, p.bg0) or p.none,
		fg = diagnostics_error_color,
	},
	DiagnosticVirtualTextWarn = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_warn_color, 0.1, p.bg0) or p.none,
		fg = diagnostics_warn_color,
	},
	DiagnosticVirtualTextInfo = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_info_color, 0.1, p.bg0) or p.none,
		fg = diagnostics_info_color,
	},
	DiagnosticVirtualTextHint = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_hint_color, 0.1, p.bg0) or p.none,
		fg = diagnostics_hint_color,
	},

	DiagnosticUnderlineError = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = p.red },
	DiagnosticUnderlineHint = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = p.grape },
	DiagnosticUnderlineInfo = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = p.blue },
	DiagnosticUnderlineWarn = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = p.yellow },

	LspReferenceText = { bg = p.bg2 },
	LspReferenceWrite = { bg = p.bg2 },
	LspReferenceRead = { bg = p.bg2 },

	LspCodeLens = { fg = p.grey, fmt = cfg.code_style.comments },
	LspCodeLensSeparator = { fg = p.grey },
}

hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError
hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint
hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo
hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp.DiagnosticVirtualTextError
hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp.DiagnosticVirtualTextWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp.DiagnosticVirtualTextInfo
hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp.DiagnosticVirtualTextHint

hl.plugins.ale = {
	ALEErrorSign = hl.plugins.lsp.DiagnosticError,
	ALEInfoSign = hl.plugins.lsp.DiagnosticInfo,
	ALEWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.barbar = {
	BufferCurrent = { fmt = "bold" },
	BufferCurrentMod = { fg = p.orange, fmt = "bold,italic" },
	BufferCurrentSign = { fg = p.grape },
	BufferInactiveMod = { fg = p.light_grey, bg = p.bg1, fmt = "italic" },
	BufferVisible = { fg = p.light_grey, bg = p.bg0 },
	BufferVisibleMod = { fg = p.yellow, bg = p.bg0, fmt = "italic" },
	BufferVisibleIndex = { fg = p.light_grey, bg = p.bg0 },
	BufferVisibleSign = { fg = p.light_grey, bg = p.bg0 },
	BufferVisibleTarget = { fg = p.light_grey, bg = p.bg0 },
}

hl.plugins.cmp = {
	CmpItemAbbr = colors.Fg,
	CmpItemAbbrDeprecated = { fg = p.light_grey, fmt = "strikethrough" },
	CmpItemAbbrMatch = colors.Cyan,
	CmpItemAbbrMatchFuzzy = { fg = p.cyan, fmt = "underline" },
	CmpItemMenu = colors.LightGrey,
	CmpItemKind = { fg = p.grape, fmt = cfg.cmp_itemkind_reverse and "reverse" },
}

hl.plugins.coc = {
	CocErrorSign = hl.plugins.lsp.DiagnosticError,
	CocHintSign = hl.plugins.lsp.DiagnosticHint,
	CocInfoSign = hl.plugins.lsp.DiagnosticInfo,
	CocWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.whichkey = {
	WhichKey = colors.Red,
	WhichKeyDesc = colors.Blue,
	WhichKeyGroup = colors.Orange,
	WhichKeySeparator = colors.Green,
}

hl.plugins.gitgutter = {
	GitGutterAdd = { fg = p.green },
	GitGutterChange = { fg = p.blue },
	GitGutterDelete = { fg = p.red },
}

hl.plugins.hop = {
	HopNextKey = { fg = p.red, fmt = "bold" },
	HopNextKey1 = { fg = p.cyan, fmt = "bold" },
	HopNextKey2 = { fg = util.darken(p.blue, 0.7) },
	HopUnmatched = colors.Grey,
}

-- comment
hl.plugins.diffview = {
	DiffviewFilePanelTitle = { fg = p.blue, fmt = "bold" },
	DiffviewFilePanelCounter = { fg = p.grape, fmt = "bold" },
	DiffviewFilePanelFileName = colors.Fg,
	DiffviewNormal = hl.common.Normal,
	DiffviewCursorLine = hl.common.CursorLine,
	DiffviewVertSplit = hl.common.VertSplit,
	DiffviewSignColumn = hl.common.SignColumn,
	DiffviewStatusLine = hl.common.StatusLine,
	DiffviewStatusLineNC = hl.common.StatusLineNC,
	DiffviewEndOfBuffer = hl.common.EndOfBuffer,
	DiffviewFilePanelRootPath = colors.Grey,
	DiffviewFilePanelPath = colors.Grey,
	DiffviewFilePanelInsertions = colors.Green,
	DiffviewFilePanelDeletions = colors.Red,
	DiffviewStatusAdded = colors.Green,
	DiffviewStatusUntracked = colors.Blue,
	DiffviewStatusModified = colors.Blue,
	DiffviewStatusRenamed = colors.Blue,
	DiffviewStatusCopied = colors.Blue,
	DiffviewStatusTypeChange = colors.Blue,
	DiffviewStatusUnmerged = colors.Blue,
	DiffviewStatusUnknown = colors.Red,
	DiffviewStatusDeleted = colors.Red,
	DiffviewStatusBroken = colors.Red,
}

hl.plugins.gitsigns = {
	GitSignsAdd = colors.Green,
	GitSignsAddLn = colors.Green,
	GitSignsAddNr = colors.Green,
	GitSignsChange = colors.Blue,
	GitSignsChangeLn = colors.Blue,
	GitSignsChangeNr = colors.Blue,
	GitSignsDelete = colors.Red,
	GitSignsDeleteLn = colors.Red,
	GitSignsDeleteNr = colors.Red,
}

hl.plugins.neo_tree = {
	NeoTreeNormal = { fg = p.fg, bg = cfg.transparent and p.none or p.bg_d },
	NeoTreeNormalNC = { fg = p.fg, bg = cfg.transparent and p.none or p.bg_d },
	NeoTreeVertSplit = { fg = p.bg1, bg = cfg.transparent and p.none or p.bg1 },
	NeoTreeWinSeparator = { fg = p.bg1, bg = cfg.transparent and p.none or p.bg1 },
	NeoTreeEndOfBuffer = { fg = cfg.ending_tildes and p.bg2 or p.bg_d, bg = cfg.transparent and p.none or p.bg_d },
	NeoTreeRootName = { fg = p.orange, fmt = "bold" },
	NeoTreeGitAdded = colors.Green,
	NeoTreeGitDeleted = colors.Red,
	NeoTreeGitModified = colors.Yellow,
	NeoTreeGitConflict = { fg = p.red, fmt = "bold,italic" },
	NeoTreeGitUntracked = { fg = p.red, fmt = "italic" },
	NeoTreeIndentMarker = colors.Grey,
	NeoTreeSymbolicLinkTarget = colors.Purple,
}

hl.plugins.neotest = {
	NeotestAdapterName = { fg = p.grape, fmt = "bold" },
	NeotestDir = colors.Cyan,
	NeotestExpandMarker = colors.Grey,
	NeotestFailed = colors.Red,
	NeotestFile = colors.Cyan,
	NeotestFocused = { fmt = "bold,italic" },
	NeotestIndent = colors.Grey,
	NeotestMarked = { fg = p.orange, fmt = "bold" },
	NeotestNamespace = colors.Blue,
	NeotestPassed = colors.Green,
	NeotestRunning = colors.Yellow,
	NeotestWinSelect = { fg = p.cyan, fmt = "bold" },
	NeotestSkipped = colors.LightGrey,
	NeotestTarget = colors.Purple,
	NeotestTest = colors.Fg,
	NeotestUnknown = colors.LightGrey,
}

hl.plugins.nvim_tree = {
	NvimTreeNormal = { fg = p.fg, bg = cfg.transparent and p.none or p.bg_d },
	NvimTreeVertSplit = { fg = p.bg_d, bg = cfg.transparent and p.none or p.bg_d },
	NvimTreeEndOfBuffer = { fg = cfg.ending_tildes and p.bg2 or p.bg_d, bg = cfg.transparent and p.none or p.bg_d },
	NvimTreeRootFolder = { fg = p.orange, fmt = "bold" },
	NvimTreeGitDirty = colors.Yellow,
	NvimTreeGitNew = colors.Green,
	NvimTreeGitDeleted = colors.Red,
	NvimTreeSpecialFile = { fg = p.yellow, fmt = "underline" },
	NvimTreeIndentMarker = colors.Fg,
	NvimTreeImageFile = { fg = p.dark_purple },
	NvimTreeSymlink = colors.Purple,
	NvimTreeFolderName = colors.Blue,
}
hl.plugins.telescope = {
	TelescopeBorder = colors.Red,
	TelescopePromptBorder = colors.Cyan,
	TelescopeResultsBorder = colors.Cyan,
	TelescopePreviewBorder = colors.Cyan,
	TelescopeMatching = { fg = p.orange, fmt = "bold" },
	TelescopePromptPrefix = colors.Green,
	TelescopeSelection = { bg = p.bg2 },
	TelescopeSelectionCaret = colors.Yellow,
}

hl.plugins.dashboard = {
	DashboardShortCut = colors.Blue,
	DashboardHeader = colors.Yellow,
	DashboardCenter = colors.Cyan,
	DashboardFooter = { fg = p.dark_red, fmt = "italic" },
}

hl.plugins.outline = {
	FocusedSymbol = { fg = p.grape, bg = p.bg2, fmt = "bold" },
	AerialLine = { fg = p.grape, bg = p.bg2, fmt = "bold" },
}

hl.plugins.navic = {
	NavicText = { fg = p.fg },
	NavicSeparator = { fg = p.light_grey },
}

hl.plugins.ts_rainbow = {
	rainbowcol1 = colors.LightGrey,
	rainbowcol2 = colors.Yellow,
	rainbowcol3 = colors.Blue,
	rainbowcol4 = colors.Orange,
	rainbowcol5 = colors.Purple,
	rainbowcol6 = colors.Green,
	rainbowcol7 = colors.Red,
}

hl.plugins.ts_rainbow2 = {
	TSRainbowRed = colors.Red,
	TSRainbowYellow = colors.Yellow,
	TSRainbowBlue = colors.Blue,
	TSRainbowOrange = colors.Orange,
	TSRainbowGreen = colors.Green,
	TSRainbowViolet = colors.Purple,
	TSRainbowCyan = colors.Cyan,
}

hl.plugins.rainbow_delimiters = {
	RainbowDelimiterRed = colors.Red,
	RainbowDelimiterYellow = colors.Yellow,
	RainbowDelimiterBlue = colors.Blue,
	RainbowDelimiterOrange = colors.Orange,
	RainbowDelimiterGreen = colors.Green,
	RainbowDelimiterViolet = colors.Purple,
	RainbowDelimiterCyan = colors.Cyan,
}

hl.plugins.indent_blankline = {
	IndentBlanklineIndent1 = colors.Blue,
	IndentBlanklineIndent2 = colors.Green,
	IndentBlanklineIndent3 = colors.Cyan,
	IndentBlanklineIndent4 = colors.LightGrey,
	IndentBlanklineIndent5 = colors.Purple,
	IndentBlanklineIndent6 = colors.Red,
	IndentBlanklineChar = { fg = p.bg1, fmt = "nocombine" },
	IndentBlanklineContextChar = { fg = p.grey, fmt = "nocombine" },
	IndentBlanklineContextStart = { sp = p.grey, fmt = "underline" },
	IndentBlanklineContextSpaceChar = { fmt = "nocombine" },

	-- Ibl v3
	IblIndent = { fg = p.bg1, fmt = "nocombine" },
	IblWhitespace = { fg = p.grey, fmt = "nocombine" },
	IblScope = { fg = p.grey, fmt = "nocombine" },
}

hl.plugins.mini = {
	MiniCompletionActiveParameter = { fmt = "underline" },

	MiniCursorword = { fmt = "underline" },
	MiniCursorwordCurrent = { fmt = "underline" },

	MiniIndentscopeSymbol = { fg = p.grey },
	MiniIndentscopePrefix = { fmt = "nocombine" }, -- Make it invisible

	MiniJump = { fg = p.grape, fmt = "underline", sp = p.grape },

	MiniJump2dSpot = { fg = p.red, fmt = "bold,nocombine" },

	MiniStarterCurrent = { fmt = "nocombine" },
	MiniStarterFooter = { fg = p.dark_red, fmt = "italic" },
	MiniStarterHeader = colors.Yellow,
	MiniStarterInactive = { fg = p.grey, fmt = cfg.code_style.comments },
	MiniStarterItem = { fg = p.fg, bg = cfg.transparent and p.none or p.bg0 },
	MiniStarterItemBullet = { fg = p.grey },
	MiniStarterItemPrefix = { fg = p.yellow },
	MiniStarterSection = colors.LightGrey,
	MiniStarterQuery = { fg = p.cyan },

	MiniStatuslineDevinfo = { fg = p.fg, bg = p.bg2 },
	MiniStatuslineFileinfo = { fg = p.fg, bg = p.bg2 },
	MiniStatuslineFilename = { fg = p.grey, bg = p.bg1 },
	MiniStatuslineInactive = { fg = p.grey, bg = p.bg0 },
	MiniStatuslineModeCommand = { fg = p.bg0, bg = p.yellow, fmt = "bold" },
	MiniStatuslineModeInsert = { fg = p.bg0, bg = p.blue, fmt = "bold" },
	MiniStatuslineModeNormal = { fg = p.bg0, bg = p.green, fmt = "bold" },
	MiniStatuslineModeOther = { fg = p.bg0, bg = p.cyan, fmt = "bold" },
	MiniStatuslineModeReplace = { fg = p.bg0, bg = p.red, fmt = "bold" },
	MiniStatuslineModeVisual = { fg = p.bg0, bg = p.grape, fmt = "bold" },

	MiniSurround = { fg = p.bg0, bg = p.orange },

	MiniTablineCurrent = { fmt = "bold" },
	MiniTablineFill = { fg = p.grey, bg = p.bg1 },
	MiniTablineHidden = { fg = p.fg, bg = p.bg1 },
	MiniTablineModifiedCurrent = { fg = p.orange, fmt = "bold,italic" },
	MiniTablineModifiedHidden = { fg = p.light_grey, bg = p.bg1, fmt = "italic" },
	MiniTablineModifiedVisible = { fg = p.yellow, bg = p.bg0, fmt = "italic" },
	MiniTablineTabpagesection = { fg = p.bg0, bg = p.bg_yellow },
	MiniTablineVisible = { fg = p.light_grey, bg = p.bg0 },

	MiniTestEmphasis = { fmt = "bold" },
	MiniTestFail = { fg = p.red, fmt = "bold" },
	MiniTestPass = { fg = p.green, fmt = "bold" },

	MiniTrailspace = { bg = p.red },
}

hl.langs.c = {
	cInclude = colors.Blue,
	cStorageClass = colors.Purple,
	cTypedef = colors.Purple,
	cDefine = colors.Cyan,
	cTSInclude = colors.Blue,
	cTSConstant = colors.Cyan,
	cTSConstMacro = colors.Purple,
	cTSOperator = colors.Purple,
}

hl.langs.cpp = {
	cppStatement = { fg = p.grape, fmt = "bold" },
	cppTSInclude = colors.Blue,
	cppTSConstant = colors.Cyan,
	cppTSConstMacro = colors.Purple,
	cppTSOperator = colors.Purple,
}

hl.langs.markdown = {
	markdownBlockquote = colors.Grey,
	markdownBold = { fg = p.none, fmt = "bold" },
	markdownBoldDelimiter = colors.Grey,
	markdownCode = colors.Green,
	markdownCodeBlock = colors.Green,
	markdownCodeDelimiter = colors.Yellow,
	markdownH1 = { fg = p.red, fmt = "bold" },
	markdownH2 = { fg = p.grape, fmt = "bold" },
	markdownH3 = { fg = p.orange, fmt = "bold" },
	markdownH4 = { fg = p.red, fmt = "bold" },
	markdownH5 = { fg = p.grape, fmt = "bold" },
	markdownH6 = { fg = p.orange, fmt = "bold" },
	markdownHeadingDelimiter = colors.Grey,
	markdownHeadingRule = colors.Grey,
	markdownId = colors.Yellow,
	markdownIdDeclaration = colors.Red,
	markdownItalic = { fg = p.none, fmt = "italic" },
	markdownItalicDelimiter = { fg = p.grey, fmt = "italic" },
	markdownLinkDelimiter = colors.Grey,
	markdownLinkText = colors.Red,
	markdownLinkTextDelimiter = colors.Grey,
	markdownListMarker = colors.Red,
	markdownOrderedListMarker = colors.Red,
	markdownRule = colors.Purple,
	markdownUrl = { fg = p.blue, fmt = "underline" },
	markdownUrlDelimiter = colors.Grey,
	markdownUrlTitleDelimiter = colors.Green,
}

hl.langs.php = {
	phpFunctions = { fg = p.fg, fmt = cfg.code_style.functions },
	phpMethods = colors.Cyan,
	phpStructure = colors.Purple,
	phpOperator = colors.Purple,
	phpMemberSelector = colors.Fg,
	phpVarSelector = { fg = p.orange, fmt = cfg.code_style.variables },
	phpIdentifier = { fg = p.orange, fmt = cfg.code_style.variables },
	phpBoolean = colors.Cyan,
	phpNumber = colors.Orange,
	phpHereDoc = colors.Green,
	phpNowDoc = colors.Green,
	phpSCKeyword = { fg = p.grape, fmt = cfg.code_style.keywords },
	phpFCKeyword = { fg = p.grape, fmt = cfg.code_style.keywords },
	phpRegion = colors.Blue,
}

hl.langs.scala = {
	scalaNameDefinition = colors.Fg,
	scalaInterpolationBoundary = colors.Purple,
	scalaInterpolation = colors.Purple,
	scalaTypeOperator = colors.Red,
	scalaOperator = colors.Red,
	scalaKeywordModifier = { fg = p.red, fmt = cfg.code_style.keywords },
}

hl.langs.tex = {
	latexTSInclude = colors.Blue,
	latexTSFuncMacro = { fg = p.fg, fmt = cfg.code_style.functions },
	latexTSEnvironment = { fg = p.cyan, fmt = "bold" },
	latexTSEnvironmentName = colors.Yellow,
	texCmdEnv = colors.Cyan,
	texEnvArgName = colors.Yellow,
	latexTSTitle = colors.Green,
	latexTSType = colors.Blue,
	latexTSMath = colors.Orange,
	texMathZoneX = colors.Orange,
	texMathZoneXX = colors.Orange,
	texMathDelimZone = colors.LightGrey,
	texMathDelim = colors.Purple,
	texMathOper = colors.Red,
	texCmd = colors.Purple,
	texCmdPart = colors.Blue,
	texCmdPackage = colors.Blue,
	texPgfType = colors.Yellow,
}

hl.langs.vim = {
	vimOption = colors.Red,
	vimSetEqual = colors.Yellow,
	vimMap = colors.Purple,
	vimMapModKey = colors.Orange,
	vimNotation = colors.Red,
	vimMapLhs = colors.Fg,
	vimMapRhs = colors.Blue,
	vimVar = { fg = p.fg, fmt = cfg.code_style.variables },
	vimCommentTitle = { fg = p.light_grey, fmt = cfg.code_style.comments },
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
	Null = p.grey,
	Number = p.orange,
	Object = p.red,
	Operator = p.red,
	Package = p.yellow,
	Property = p.cyan,
	Reference = p.orange,
	Snippet = p.red,
	String = p.green,
	Struct = p.grape,
	Text = p.light_grey,
	TypeParameter = p.red,
	Unit = p.green,
	Value = p.orange,
	Variable = p.grape,
}

function M.setup()
	-- define cmp and aerial kind highlights with lsp_kind_icons_color
	for kind, color in pairs(lsp_kind_icons_color) do
		hl.plugins.cmp["CmpItemKind" .. kind] = { fg = color, fmt = cfg.cmp_itemkind_reverse and "reverse" }
		hl.plugins.outline["Aerial" .. kind .. "Icon"] = { fg = color }
		hl.plugins.navic["NavicIcons" .. kind] = { fg = color }
	end

	vim_highlights(hl.common)
	vim_highlights(hl.syntax)
	vim_highlights(hl.treesitter)
	if hl.lsp then
		vim_highlights(hl.lsp)
	end
	for _, group in pairs(hl.langs) do
		vim_highlights(group)
	end
	for _, group in pairs(hl.plugins) do
		vim_highlights(group)
	end

	-- user defined highlights: vim_highlights function cannot be used because it sets an attribute to none if not specified
	local function replace_color(prefix, color_name)
		if not color_name then
			return ""
		end
		if color_name:sub(1, 1) == "$" then
			local name = color_name:sub(2, -1)
			color_name = p[name]
			if not color_name then
				vim.schedule(function()
					vim.notify(
						'caironoon.nvim: unknown color "' .. name .. '"',
						vim.log.levels.ERROR,
						{ title = "caironoon.nvim" }
					)
				end)
				return ""
			end
		end
		return prefix .. "=" .. color_name
	end

	for group_name, group_settings in pairs(vim.g.caironoon_config.highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s %s %s %s %s",
				group_name,
				replace_color("guifg", group_settings.fg),
				replace_color("guibg", group_settings.bg),
				replace_color("guisp", group_settings.sp),
				replace_color("gui", group_settings.fmt)
			)
		)
	end
end

return M
