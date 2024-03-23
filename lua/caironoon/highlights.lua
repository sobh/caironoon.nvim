local p = require("caironoon.palette")
local cfg = vim.g.caironoon_config
local util = require("caironoon.util")

local M = {}
local groups = { langs = {}, plugins = {} }

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

groups.common = {
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
	LineNr = { fg = p.gray },
	Conceal = { fg = p.gray, bg = p.bg1 },
	DiffAdd = { fg = p.none, bg = p.diff_add },
	DiffChange = { fg = p.none, bg = p.diff_change },
	DiffDelete = { fg = p.none, bg = p.diff_delete },
	DiffText = { fg = p.none, bg = p.diff_text },
	DiffAdded = { fg = p.green },
	DiffRemoved = { fg = p.red },
	DiffFile = { fg = p.cyan },
	DiffIndexLine = { fg = p.gray },
	Directory = { fg = p.blue },
	ErrorMsg = { fg = p.red, fmt = "bold" },
	WarningMsg = { fg = p.yellow, fmt = "bold" },
	MoreMsg = { fg = p.blue, fmt = "bold" },
	CurSearch = { fg = p.bg0, bg = p.orange },
	IncSearch = { fg = p.bg0, bg = p.orange },
	Search = { fg = p.bg0, bg = p.bg_yellow },
	Substitute = { fg = p.bg0, bg = p.green },
	MatchParen = { fg = p.none, bg = p.gray },
	NonText = { fg = p.gray },
	Whitespace = { fg = p.gray },
	SpecialKey = { fg = p.gray },
	Pmenu = { fg = p.fg, bg = p.bg1 },
	PmenuSbar = { fg = p.none, bg = p.bg1 },
	PmenuSel = { fg = p.bg0, bg = p.bg_blue },
	WildMenu = { fg = p.bg0, bg = p.blue },
	PmenuThumb = { fg = p.none, bg = p.gray },
	Question = { fg = p.yellow },
	SpellBad = { fg = p.none, fmt = "undercurl", sp = p.red },
	SpellCap = { fg = p.none, fmt = "undercurl", sp = p.yellow },
	SpellLocal = { fg = p.none, fmt = "undercurl", sp = p.blue },
	SpellRare = { fg = p.none, fmt = "undercurl", sp = p.grape },
	StatusLine = { fg = p.fg, bg = p.bg2 },
	StatusLineTerm = { fg = p.fg, bg = p.bg2 },
	StatusLineNC = { fg = p.gray, bg = p.bg1 },
	StatusLineTermNC = { fg = p.gray, bg = p.bg1 },
	TabLine = { fg = p.fg, bg = p.bg1 },
	TabLineFill = { fg = p.gray, bg = p.bg1 },
	TabLineSel = { fg = p.bg0, bg = p.fg },
	WinSeparator = { fg = p.bg3 },
	Visual = { bg = p.bg3 },
	VisualNOS = { fg = p.none, bg = p.bg2, fmt = "underline" },
	QuickFixLine = { fg = p.blue, fmt = "underline" },
	Debug = { fg = p.yellow },
	debugPC = { fg = p.bg0, bg = p.green },
	debugBreakpoint = { fg = p.bg0, bg = p.red },
	ToolbarButton = { fg = p.bg0, bg = p.bg_blue },
	FloatBorder = { fg = p.gray, bg = p.bg1 },
	NormalFloat = { fg = p.fg, bg = p.bg1 },
}

groups.syntax = {
	String = { fg = p.green, fmt = cfg.code_style.strings },
	Character = { fg = p.orange },
	Number = { fg = p.orange },
	Float = { fg = p.orange },
	Boolean = { fg = p.orange },
	Type = { fg = p.yellow },
	Structure = { fg = p.yellow },
	StorageClass = { fg = p.yellow },
	Identifier = { fg = p.red, fmt = cfg.code_style.variables },
	Constant = { fg = p.cyan },
	PreProc = { fg = p.purple },
	PreCondit = { fg = p.purple },
	Include = { fg = p.purple },
	Keyword = { fg = p.grape, fmt = cfg.code_style.keywords },
	Define = { fg = p.purple },
	Typedef = { fg = p.yellow },
	Exception = { fg = p.purple },
	Conditional = { fg = p.grape, fmt = cfg.code_style.keywords },
	Repeat = { fg = p.grape, fmt = cfg.code_style.keywords },
	Statement = { fg = p.purple },
	Macro = { fg = p.red },
	Error = { fg = p.purple },
	Label = { fg = p.purple },
	Special = { fg = p.red },
	SpecialChar = { fg = p.red },
	Function = { fg = p.blue, fmt = cfg.code_style.functions },
	Operator = { fg = p.purple },
	Title = { fg = p.cyan },
	Tag = { fg = p.green },
	Delimiter = { fg = p.light_gray },
	Comment = { fg = p.comment, fmt = cfg.code_style.comments },
	SpecialComment = { fg = p.comment, fmt = cfg.code_style.comments },
	Todo = { fg = p.orange, fmt = cfg.code_style.comments },
}

groups.treesitter = {
	["@annotation"] = { fg = p.fg },
	["@attribute"] = { fg = p.cyan },
	["@attribute.typescript"] = { fg = p.blue },
	["@boolean"] = { fg = p.orange },
	["@character"] = { fg = p.orange },
	["@comment"] = groups.syntax.Comment,
	["@comment.todo"] = groups.syntax.Comment,
	["@comment.todo.unchecked"] = { fg = p.red, fmt = cfg.code_style.comments },
	["@comment.todo.checked"] = { fg = p.green, fmt = cfg.code_style.comments },
	["@constant"] = { fg = p.orange, fmt = cfg.code_style.constants },
	["@constant.builtin"] = { fg = p.orange, fmt = cfg.code_style.constants },
	["@constant.macro"] = { fg = p.orange, fmt = cfg.code_style.constants },
	["@constructor"] = { fg = p.yellow, fmt = "bold" },
	["@diff.add"] = { fg = p.green },
	["@diff.delete"] = { fg = p.red },
	["@error"] = { fg = p.fg },
	["@function"] = { fg = p.blue, fmt = cfg.code_style.functions },
	["@function.builtin"] = { fg = p.cyan, fmt = cfg.code_style.functions },
	["@function.macro"] = { fg = p.cyan, fmt = cfg.code_style.functions },
	["@function.method"] = { fg = p.blue, fmt = cfg.code_style.functions },
	["@keyword"] = { fg = p.grape, fmt = cfg.code_style.keywords },
	["@keyword.conditional"] = { fg = p.grape, fmt = cfg.code_style.keywords },
	["@keyword.directive"] = { fg = p.purple },
	["@keyword.exception"] = { fg = p.purple },
	["@keyword.function"] = { fg = p.grape, fmt = cfg.code_style.functions },
	["@keyword.import"] = { fg = p.purple },
	["@keyword.operator"] = { fg = p.grape, fmt = cfg.code_style.keywords },
	["@keyword.repeat"] = { fg = p.grape, fmt = cfg.code_style.keywords },
	["@label"] = { fg = p.red },
	["@markup.emphasis"] = { fg = p.fg, fmt = "italic" },
	["@markup.environment"] = { fg = p.fg },
	["@markup.environment.name"] = { fg = p.fg },
	["@markup.heading"] = { fg = p.orange, fmt = "bold" },
	["@markup.link"] = { fg = p.blue },
	["@markup.link.url"] = { fg = p.cyan, fmt = "underline" },
	["@markup.list"] = { fg = p.red },
	["@markup.math"] = { fg = p.fg },
	["@markup.raw"] = { fg = p.green },
	["@markup.strike"] = { fg = p.fg, fmt = "strikethrough" },
	["@markup.strong"] = { fg = p.fg, fmt = "bold" },
	["@markup.underline"] = { fg = p.fg, fmt = "underline" },
	["@module"] = { fg = p.yellow },
	["@none"] = { fg = p.fg },
	["@number"] = { fg = p.orange },
	["@number.float"] = { fg = p.orange },
	["@operator"] = { fg = p.fg },
	["@parameter.reference"] = { fg = p.fg },
	["@property"] = { fg = p.cyan },
	["@punctuation.delimiter"] = { fg = p.light_gray },
	["@punctuation.bracket"] = { fg = p.light_gray },
	["@string"] = { fg = p.green, fmt = cfg.code_style.strings },
	["@string.regexp"] = { fg = p.orange, fmt = cfg.code_style.strings },
	["@string.escape"] = { fg = p.red, fmt = cfg.code_style.strings },
	["@string.special.symbol"] = { fg = p.cyan },
	["@tag"] = { fg = p.purple },
	["@tag.attribute"] = { fg = p.yellow },
	["@tag.delimiter"] = { fg = p.purple },
	["@text"] = { fg = p.fg },
	["@note"] = { fg = p.green },
	["@warning"] = { fg = p.fg },
	["@danger"] = { fg = p.fg },
	["@type"] = { fg = p.yellow },
	["@type.builtin"] = { fg = p.orange },
	["@variable"] = { fg = p.fg, fmt = cfg.code_style.variables },
	["@variable.builtin"] = { fg = p.red, fmt = cfg.code_style.variables },
	["@variable.member"] = { fg = p.cyan },
	["@variable.parameter"] = { fg = p.red },
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

local diagnostics_error_color = cfg.diagnostics.darker and p.dark_red or p.red
local diagnostics_hint_color = cfg.diagnostics.darker and p.dark_purple or p.grape
local diagnostics_warn_color = cfg.diagnostics.darker and p.dark_yellow or p.yellow
local diagnostics_info_color = cfg.diagnostics.darker and p.dark_cyan or p.cyan
groups.plugins.lsp = {
	LspCxxHlGroupEnumConstant = { fg = p.orange },
	LspCxxHlGroupMemberVariable = { fg = p.orange },
	LspCxxHlGroupNamespace = { fg = p.blue },
	LspCxxHlSkippedRegion = { fg = p.gray },
	LspCxxHlSkippedRegionBeginEnd = { fg = p.red },

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

	LspCodeLens = { fg = p.gray, fmt = cfg.code_style.comments },
	LspCodeLensSeparator = { fg = p.gray },
}

groups.plugins.lsp.LspDiagnosticsDefaultError = groups.plugins.lsp.DiagnosticError
groups.plugins.lsp.LspDiagnosticsDefaultHint = groups.plugins.lsp.DiagnosticHint
groups.plugins.lsp.LspDiagnosticsDefaultInformation = groups.plugins.lsp.DiagnosticInfo
groups.plugins.lsp.LspDiagnosticsDefaultWarning = groups.plugins.lsp.DiagnosticWarn
groups.plugins.lsp.LspDiagnosticsUnderlineError = groups.plugins.lsp.DiagnosticUnderlineError
groups.plugins.lsp.LspDiagnosticsUnderlineHint = groups.plugins.lsp.DiagnosticUnderlineHint
groups.plugins.lsp.LspDiagnosticsUnderlineInformation = groups.plugins.lsp.DiagnosticUnderlineInfo
groups.plugins.lsp.LspDiagnosticsUnderlineWarning = groups.plugins.lsp.DiagnosticUnderlineWarn
groups.plugins.lsp.LspDiagnosticsVirtualTextError = groups.plugins.lsp.DiagnosticVirtualTextError
groups.plugins.lsp.LspDiagnosticsVirtualTextWarning = groups.plugins.lsp.DiagnosticVirtualTextWarn
groups.plugins.lsp.LspDiagnosticsVirtualTextInformation = groups.plugins.lsp.DiagnosticVirtualTextInfo
groups.plugins.lsp.LspDiagnosticsVirtualTextHint = groups.plugins.lsp.DiagnosticVirtualTextHint

groups.plugins.ale = {
	ALEErrorSign = groups.plugins.lsp.DiagnosticError,
	ALEInfoSign = groups.plugins.lsp.DiagnosticInfo,
	ALEWarningSign = groups.plugins.lsp.DiagnosticWarn,
}

groups.plugins.barbar = {
	BufferCurrent = { fmt = "bold" },
	BufferCurrentMod = { fg = p.orange, fmt = "bold,italic" },
	BufferCurrentSign = { fg = p.grape },
	BufferInactiveMod = { fg = p.light_gray, bg = p.bg1, fmt = "italic" },
	BufferVisible = { fg = p.light_gray, bg = p.bg0 },
	BufferVisibleMod = { fg = p.yellow, bg = p.bg0, fmt = "italic" },
	BufferVisibleIndex = { fg = p.light_gray, bg = p.bg0 },
	BufferVisibleSign = { fg = p.light_gray, bg = p.bg0 },
	BufferVisibleTarget = { fg = p.light_gray, bg = p.bg0 },
}

groups.plugins.cmp = {
	CmpItemAbbr = { fg = p.fg },
	CmpItemAbbrDeprecated = { fg = p.light_gray, fmt = "strikethrough" },
	CmpItemAbbrMatch = { fg = p.cyan },
	CmpItemAbbrMatchFuzzy = { fg = p.cyan, fmt = "underline" },
	CmpItemMenu = { fg = p.light_gray },
	CmpItemKind = { fg = p.grape, fmt = cfg.cmp_itemkind_reverse and "reverse" },
}

groups.plugins.coc = {
	CocErrorSign = groups.plugins.lsp.DiagnosticError,
	CocHintSign = groups.plugins.lsp.DiagnosticHint,
	CocInfoSign = groups.plugins.lsp.DiagnosticInfo,
	CocWarningSign = groups.plugins.lsp.DiagnosticWarn,
}

groups.plugins.whichkey = {
	WhichKey = { fg = p.red },
	WhichKeyDesc = { fg = p.blue },
	WhichKeyGroup = { fg = p.orange },
	WhichKeySeparator = { fg = p.green },
}

groups.plugins.gitgutter = {
	GitGutterAdd = { fg = p.green },
	GitGutterChange = { fg = p.blue },
	GitGutterDelete = { fg = p.red },
}

groups.plugins.hop = {
	HopNextKey = { fg = p.red, fmt = "bold" },
	HopNextKey1 = { fg = p.cyan, fmt = "bold" },
	HopNextKey2 = { fg = util.darken(p.blue, 0.7) },
	HopUnmatched = { fg = p.gray },
}

-- comment
groups.plugins.diffview = {
	DiffviewFilePanelTitle = { fg = p.blue, fmt = "bold" },
	DiffviewFilePanelCounter = { fg = p.grape, fmt = "bold" },
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
}

groups.plugins.gitsigns = {
	GitSignsAdd = { fg = p.green },
	GitSignsAddLn = { fg = p.green },
	GitSignsAddNr = { fg = p.green },
	GitSignsChange = { fg = p.blue },
	GitSignsChangeLn = { fg = p.blue },
	GitSignsChangeNr = { fg = p.blue },
	GitSignsDelete = { fg = p.red },
	GitSignsDeleteLn = { fg = p.red },
	GitSignsDeleteNr = { fg = p.red },
}

groups.plugins.neo_tree = {
	NeoTreeNormal = { fg = p.fg, bg = cfg.transparent and p.none or p.bg_d },
	NeoTreeNormalNC = { fg = p.fg, bg = cfg.transparent and p.none or p.bg_d },
	NeoTreeVertSplit = { fg = p.bg1, bg = cfg.transparent and p.none or p.bg1 },
	NeoTreeWinSeparator = { fg = p.bg1, bg = cfg.transparent and p.none or p.bg1 },
	NeoTreeEndOfBuffer = { fg = cfg.ending_tildes and p.bg2 or p.bg_d, bg = cfg.transparent and p.none or p.bg_d },
	NeoTreeRootName = { fg = p.orange, fmt = "bold" },
	NeoTreeGitAdded = { fg = p.green },
	NeoTreeGitDeleted = { fg = p.red },
	NeoTreeGitModified = { fg = p.yellow },
	NeoTreeGitConflict = { fg = p.red, fmt = "bold,italic" },
	NeoTreeGitUntracked = { fg = p.red, fmt = "italic" },
	NeoTreeIndentMarker = { fg = p.gray },
	NeoTreeSymbolicLinkTarget = { fg = p.purple },
}

groups.plugins.neotest = {
	NeotestAdapterName = { fg = p.grape, fmt = "bold" },
	NeotestDir = { fg = p.cyan },
	NeotestExpandMarker = { fg = p.gray },
	NeotestFailed = { fg = p.red },
	NeotestFile = { fg = p.cyan },
	NeotestFocused = { fmt = "bold,italic" },
	NeotestIndent = { fg = p.gray },
	NeotestMarked = { fg = p.orange, fmt = "bold" },
	NeotestNamespace = { fg = p.blue },
	NeotestPassed = { fg = p.green },
	NeotestRunning = { fg = p.yellow },
	NeotestWinSelect = { fg = p.cyan, fmt = "bold" },
	NeotestSkipped = { fg = p.light_gray },
	NeotestTarget = { fg = p.purple },
	NeotestTest = { fg = p.fg },
	NeotestUnknown = { fg = p.light_gray },
}

groups.plugins.nvim_tree = {
	NvimTreeNormal = { fg = p.fg, bg = cfg.transparent and p.none or p.bg_d },
	NvimTreeVertSplit = { fg = p.bg_d, bg = cfg.transparent and p.none or p.bg_d },
	NvimTreeEndOfBuffer = { fg = cfg.ending_tildes and p.bg2 or p.bg_d, bg = cfg.transparent and p.none or p.bg_d },
	NvimTreeRootFolder = { fg = p.orange, fmt = "bold" },
	NvimTreeGitDirty = { fg = p.yellow },
	NvimTreeGitNew = { fg = p.green },
	NvimTreeGitDeleted = { fg = p.red },
	NvimTreeSpecialFile = { fg = p.yellow, fmt = "underline" },
	NvimTreeIndentMarker = { fg = p.fg },
	NvimTreeImageFile = { fg = p.dark_purple },
	NvimTreeSymlink = { fg = p.purple },
	NvimTreeFolderName = { fg = p.blue },
}
groups.plugins.telescope = {
	TelescopeBorder = { fg = p.red },
	TelescopePromptBorder = { fg = p.cyan },
	TelescopeResultsBorder = { fg = p.cyan },
	TelescopePreviewBorder = { fg = p.cyan },
	TelescopeMatching = { fg = p.orange, fmt = "bold" },
	TelescopePromptPrefix = { fg = p.green },
	TelescopeSelection = { bg = p.bg2 },
	TelescopeSelectionCaret = { fg = p.yellow },
}

groups.plugins.dashboard = {
	DashboardShortCut = { fg = p.blue },
	DashboardHeader = { fg = p.yellow },
	DashboardCenter = { fg = p.cyan },
	DashboardFooter = { fg = p.dark_red, fmt = "italic" },
}

groups.plugins.outline = {
	FocusedSymbol = { fg = p.grape, bg = p.bg2, fmt = "bold" },
	AerialLine = { fg = p.grape, bg = p.bg2, fmt = "bold" },
}

groups.plugins.navic = {
	NavicText = { fg = p.fg },
	NavicSeparator = { fg = p.light_gray },
}

groups.plugins.ts_rainbow = {
	rainbowcol1 = { fg = p.light_gray },
	rainbowcol2 = { fg = p.yellow },
	rainbowcol3 = { fg = p.blue },
	rainbowcol4 = { fg = p.orange },
	rainbowcol5 = { fg = p.purple },
	rainbowcol6 = { fg = p.green },
	rainbowcol7 = { fg = p.red },
}

groups.plugins.ts_rainbow2 = {
	TSRainbowRed = { fg = p.red },
	TSRainbowYellow = { fg = p.yellow },
	TSRainbowBlue = { fg = p.blue },
	TSRainbowOrange = { fg = p.orange },
	TSRainbowGreen = { fg = p.green },
	TSRainbowViolet = { fg = p.purple },
	TSRainbowCyan = { fg = p.cyan },
}

groups.plugins.rainbow_delimiters = {
	RainbowDelimiterRed = { fg = p.red },
	RainbowDelimiterYellow = { fg = p.yellow },
	RainbowDelimiterBlue = { fg = p.blue },
	RainbowDelimiterOrange = { fg = p.orange },
	RainbowDelimiterGreen = { fg = p.green },
	RainbowDelimiterViolet = { fg = p.purple },
	RainbowDelimiterCyan = { fg = p.cyan },
}

groups.plugins.indent_blankline = {
	IndentBlanklineIndent1 = { fg = p.blue },
	IndentBlanklineIndent2 = { fg = p.green },
	IndentBlanklineIndent3 = { fg = p.cyan },
	IndentBlanklineIndent4 = { fg = p.light_gray },
	IndentBlanklineIndent5 = { fg = p.purple },
	IndentBlanklineIndent6 = { fg = p.red },
	IndentBlanklineChar = { fg = p.bg1, fmt = "nocombine" },
	IndentBlanklineContextChar = { fg = p.gray, fmt = "nocombine" },
	IndentBlanklineContextStart = { sp = p.gray, fmt = "underline" },
	IndentBlanklineContextSpaceChar = { fmt = "nocombine" },

	-- Ibl v3
	IblIndent = { fg = p.bg1, fmt = "nocombine" },
	IblWhitespace = { fg = p.gray, fmt = "nocombine" },
	IblScope = { fg = p.gray, fmt = "nocombine" },
}

groups.plugins.mini = {
	MiniCompletionActiveParameter = { fmt = "underline" },

	MiniCursorword = { fmt = "underline" },
	MiniCursorwordCurrent = { fmt = "underline" },

	MiniIndentscopeSymbol = { fg = p.gray },
	MiniIndentscopePrefix = { fmt = "nocombine" }, -- Make it invisible

	MiniJump = { fg = p.grape, fmt = "underline", sp = p.grape },

	MiniJump2dSpot = { fg = p.red, fmt = "bold,nocombine" },

	MiniStarterCurrent = { fmt = "nocombine" },
	MiniStarterFooter = { fg = p.dark_red, fmt = "italic" },
	MiniStarterHeader = { fg = p.yellow },
	MiniStarterInactive = { fg = p.gray, fmt = cfg.code_style.comments },
	MiniStarterItem = { fg = p.fg, bg = cfg.transparent and p.none or p.bg0 },
	MiniStarterItemBullet = { fg = p.gray },
	MiniStarterItemPrefix = { fg = p.yellow },
	MiniStarterSection = { fg = p.light_gray },
	MiniStarterQuery = { fg = p.cyan },

	MiniStatuslineDevinfo = { fg = p.fg, bg = p.bg2 },
	MiniStatuslineFileinfo = { fg = p.fg, bg = p.bg2 },
	MiniStatuslineFilename = { fg = p.gray, bg = p.bg1 },
	MiniStatuslineInactive = { fg = p.gray, bg = p.bg0 },
	MiniStatuslineModeCommand = { fg = p.bg0, bg = p.yellow, fmt = "bold" },
	MiniStatuslineModeInsert = { fg = p.bg0, bg = p.blue, fmt = "bold" },
	MiniStatuslineModeNormal = { fg = p.bg0, bg = p.green, fmt = "bold" },
	MiniStatuslineModeOther = { fg = p.bg0, bg = p.cyan, fmt = "bold" },
	MiniStatuslineModeReplace = { fg = p.bg0, bg = p.red, fmt = "bold" },
	MiniStatuslineModeVisual = { fg = p.bg0, bg = p.grape, fmt = "bold" },

	MiniSurround = { fg = p.bg0, bg = p.orange },

	MiniTablineCurrent = { fmt = "bold" },
	MiniTablineFill = { fg = p.gray, bg = p.bg1 },
	MiniTablineHidden = { fg = p.fg, bg = p.bg1 },
	MiniTablineModifiedCurrent = { fg = p.orange, fmt = "bold,italic" },
	MiniTablineModifiedHidden = { fg = p.light_gray, bg = p.bg1, fmt = "italic" },
	MiniTablineModifiedVisible = { fg = p.yellow, bg = p.bg0, fmt = "italic" },
	MiniTablineTabpagesection = { fg = p.bg0, bg = p.bg_yellow },
	MiniTablineVisible = { fg = p.light_gray, bg = p.bg0 },

	MiniTestEmphasis = { fmt = "bold" },
	MiniTestFail = { fg = p.red, fmt = "bold" },
	MiniTestPass = { fg = p.green, fmt = "bold" },

	MiniTrailspace = { bg = p.red },
}

groups.langs.c = {
	cInclude = { fg = p.blue },
	cStorageClass = { fg = p.purple },
	cTypedef = { fg = p.purple },
	cDefine = { fg = p.cyan },
	cTSInclude = { fg = p.blue },
	cTSConstant = { fg = p.cyan },
	cTSConstMacro = { fg = p.purple },
	cTSOperator = { fg = p.purple },
}

groups.langs.cpp = {
	cppStatement = { fg = p.grape, fmt = "bold" },
	cppTSInclude = { fg = p.blue },
	cppTSConstant = { fg = p.cyan },
	cppTSConstMacro = { fg = p.purple },
	cppTSOperator = { fg = p.purple },
}

groups.langs.markdown = {
	markdownBlockquote = { fg = p.gray },
	markdownBold = { fg = p.none, fmt = "bold" },
	markdownBoldDelimiter = { fg = p.gray },
	markdownCode = { fg = p.green },
	markdownCodeBlock = { fg = p.green },
	markdownCodeDelimiter = { fg = p.yellow },
	markdownH1 = { fg = p.red, fmt = "bold" },
	markdownH2 = { fg = p.grape, fmt = "bold" },
	markdownH3 = { fg = p.orange, fmt = "bold" },
	markdownH4 = { fg = p.red, fmt = "bold" },
	markdownH5 = { fg = p.grape, fmt = "bold" },
	markdownH6 = { fg = p.orange, fmt = "bold" },
	markdownHeadingDelimiter = { fg = p.gray },
	markdownHeadingRule = { fg = p.gray },
	markdownId = { fg = p.yellow },
	markdownIdDeclaration = { fg = p.red },
	markdownItalic = { fg = p.none, fmt = "italic" },
	markdownItalicDelimiter = { fg = p.gray, fmt = "italic" },
	markdownLinkDelimiter = { fg = p.gray },
	markdownLinkText = { fg = p.red },
	markdownLinkTextDelimiter = { fg = p.gray },
	markdownListMarker = { fg = p.red },
	markdownOrderedListMarker = { fg = p.red },
	markdownRule = { fg = p.purple },
	markdownUrl = { fg = p.blue, fmt = "underline" },
	markdownUrlDelimiter = { fg = p.gray },
	markdownUrlTitleDelimiter = { fg = p.green },
}

groups.langs.php = {
	phpFunctions = { fg = p.fg, fmt = cfg.code_style.functions },
	phpMethods = { fg = p.cyan },
	phpStructure = { fg = p.purple },
	phpOperator = { fg = p.purple },
	phpMemberSelector = { fg = p.fg },
	phpVarSelector = { fg = p.orange, fmt = cfg.code_style.variables },
	phpIdentifier = { fg = p.orange, fmt = cfg.code_style.variables },
	phpBoolean = { fg = p.cyan },
	phpNumber = { fg = p.orange },
	phpHereDoc = { fg = p.green },
	phpNowDoc = { fg = p.green },
	phpSCKeyword = { fg = p.grape, fmt = cfg.code_style.keywords },
	phpFCKeyword = { fg = p.grape, fmt = cfg.code_style.keywords },
	phpRegion = { fg = p.blue },
}

groups.langs.scala = {
	scalaNameDefinition = { fg = p.fg },
	scalaInterpolationBoundary = { fg = p.purple },
	scalaInterpolation = { fg = p.purple },
	scalaTypeOperator = { fg = p.red },
	scalaOperator = { fg = p.red },
	scalaKeywordModifier = { fg = p.red, fmt = cfg.code_style.keywords },
}

groups.langs.tex = {
	latexTSInclude = { fg = p.blue },
	latexTSFuncMacro = { fg = p.fg, fmt = cfg.code_style.functions },
	latexTSEnvironment = { fg = p.cyan, fmt = "bold" },
	latexTSEnvironmentName = { fg = p.yellow },
	texCmdEnv = { fg = p.cyan },
	texEnvArgName = { fg = p.yellow },
	latexTSTitle = { fg = p.green },
	latexTSType = { fg = p.blue },
	latexTSMath = { fg = p.orange },
	texMathZoneX = { fg = p.orange },
	texMathZoneXX = { fg = p.orange },
	texMathDelimZone = { fg = p.light_gray },
	texMathDelim = { fg = p.purple },
	texMathOper = { fg = p.red },
	texCmd = { fg = p.purple },
	texCmdPart = { fg = p.blue },
	texCmdPackage = { fg = p.blue },
	texPgfType = { fg = p.yellow },
}

groups.langs.vim = {
	vimOption = { fg = p.red },
	vimSetEqual = { fg = p.yellow },
	vimMap = { fg = p.purple },
	vimMapModKey = { fg = p.orange },
	vimNotation = { fg = p.red },
	vimMapLhs = { fg = p.fg },
	vimMapRhs = { fg = p.blue },
	vimVar = { fg = p.fg, fmt = cfg.code_style.variables },
	vimCommentTitle = { fg = p.light_gray, fmt = cfg.code_style.comments },
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

function M.setup()
	-- define cmp and aerial kind highlights with lsp_kind_icons_color
	for kind, color in pairs(lsp_kind_icons_color) do
		groups.plugins.cmp["CmpItemKind" .. kind] = { fg = color, fmt = cfg.cmp_itemkind_reverse and "reverse" }
		groups.plugins.outline["Aerial" .. kind .. "Icon"] = { fg = color }
		groups.plugins.navic["NavicIcons" .. kind] = { fg = color }
	end

	vim_highlights(groups.common)
	vim_highlights(groups.syntax)
	vim_highlights(groups.treesitter)
	if groups.lsp then
		vim_highlights(groups.lsp)
	end
	for _, group in pairs(groups.langs) do
		vim_highlights(group)
	end
	for _, group in pairs(groups.plugins) do
		vim_highlights(group)
	end
end

return M
