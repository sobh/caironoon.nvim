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

hl.syntax = {
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

if vim.api.nvim_call_function("has", { "nvim-0.8" }) == 1 then
	hl.treesitter = {
		-- nvim-treesitter@0.9.2 and after
		["@annotation"] = { fg = p.fg },
		["@attribute"] = { fg = p.cyan },
		["@attribute.typescript"] = { fg = p.blue },
		["@boolean"] = { fg = p.orange },
		["@character"] = { fg = p.orange },
		["@comment"] = hl.syntax.Comment,
		["@comment.todo"] = hl.syntax.Comment,
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

		-- Old configuration for nvim-treesiter@0.9.1 and below
		["@conditional"] = { fg = p.grape, fmt = cfg.code_style.keywords },
		["@exception"] = { fg = p.purple },
		["@field"] = { fg = p.cyan },
		["@float"] = { fg = p.orange },
		["@include"] = { fg = p.purple },
		["@method"] = { fg = p.blue, fmt = cfg.code_style.functions },
		["@namespace"] = { fg = p.yellow },
		["@parameter"] = { fg = p.red },
		["@preproc"] = { fg = p.purple },
		["@punctuation.special"] = { fg = p.red },
		["@repeat"] = { fg = p.grape, fmt = cfg.code_style.keywords },
		["@string.regex"] = { fg = p.orange, fmt = cfg.code_style.strings },
		["@text.strong"] = { fg = p.fg, fmt = "bold" },
		["@text.emphasis"] = { fg = p.fg, fmt = "italic" },
		["@text.underline"] = { fg = p.fg, fmt = "underline" },
		["@text.strike"] = { fg = p.fg, fmt = "strikethrough" },
		["@text.title"] = { fg = p.orange, fmt = "bold" },
		["@text.literal"] = { fg = p.green },
		["@text.uri"] = { fg = p.cyan, fmt = "underline" },
		["@text.todo"] = { fg = p.red, fmt = cfg.code_style.comments },
		["@text.todo.unchecked"] = { fg = p.red, fmt = cfg.code_style.comments },
		["@text.todo.checked"] = { fg = p.green, fmt = cfg.code_style.comments },
		["@text.math"] = { fg = p.fg },
		["@text.reference"] = { fg = p.blue },
		["@text.environment"] = { fg = p.fg },
		["@text.environment.name"] = { fg = p.fg },
		["@text.diff.add"] = { fg = p.green },
		["@text.diff.delete"] = { fg = p.red },
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
		TSAnnotation = { fg = p.fg },
		TSAttribute = { fg = p.cyan },
		TSBoolean = { fg = p.orange },
		TSCharacter = { fg = p.orange },
		TSComment = { fg = p.gray, fmt = cfg.code_style.comments },
		TSConditional = { fg = p.grape, fmt = cfg.code_style.keywords },
		TSConstant = { fg = p.orange },
		TSConstBuiltin = { fg = p.orange },
		TSConstMacro = { fg = p.orange },
		TSConstructor = { fg = p.yellow, fmt = "bold" },
		TSError = { fg = p.fg },
		TSException = { fg = p.purple },
		TSField = { fg = p.cyan },
		TSFloat = { fg = p.orange },
		TSFunction = { fg = p.blue, fmt = cfg.code_style.functions },
		TSFuncBuiltin = { fg = p.cyan, fmt = cfg.code_style.functions },
		TSFuncMacro = { fg = p.cyan, fmt = cfg.code_style.functions },
		TSInclude = { fg = p.purple },
		TSKeyword = { fg = p.grape, fmt = cfg.code_style.keywords },
		TSKeywordFunction = { fg = p.grape, fmt = cfg.code_style.functions },
		TSKeywordOperator = { fg = p.grape, fmt = cfg.code_style.keywords },
		TSLabel = { fg = p.red },
		TSMethod = { fg = p.blue, fmt = cfg.code_style.functions },
		TSNamespace = { fg = p.yellow },
		TSNone = { fg = p.fg },
		TSNumber = { fg = p.orange },
		TSOperator = { fg = p.fg },
		TSParameter = { fg = p.red },
		TSParameterReference = { fg = p.fg },
		TSProperty = { fg = p.cyan },
		TSPunctDelimiter = { fg = p.light_gray },
		TSPunctBracket = { fg = p.light_gray },
		TSPunctSpecial = { fg = p.red },
		TSRepeat = { fg = p.grape, fmt = cfg.code_style.keywords },
		TSString = { fg = p.green, fmt = cfg.code_style.strings },
		TSStringRegex = { fg = p.orange, fmt = cfg.code_style.strings },
		TSStringEscape = { fg = p.red, fmt = cfg.code_style.strings },
		TSSymbol = { fg = p.cyan },
		TSTag = { fg = p.purple },
		TSTagDelimiter = { fg = p.purple },
		TSText = { fg = p.fg },
		TSStrong = { fg = p.fg, fmt = "bold" },
		TSEmphasis = { fg = p.fg, fmt = "italic" },
		TSUnderline = { fg = p.fg, fmt = "underline" },
		TSStrike = { fg = p.fg, fmt = "strikethrough" },
		TSTitle = { fg = p.orange, fmt = "bold" },
		TSLiteral = { fg = p.green },
		TSURI = { fg = p.cyan, fmt = "underline" },
		TSMath = { fg = p.fg },
		TSTextReference = { fg = p.blue },
		TSEnvironment = { fg = p.fg },
		TSEnvironmentName = { fg = p.fg },
		TSNote = { fg = p.fg },
		TSWarning = { fg = p.fg },
		TSDanger = { fg = p.fg },
		TSType = { fg = p.yellow },
		TSTypeBuiltin = { fg = p.orange },
		TSVariable = { fg = p.fg, fmt = cfg.code_style.variables },
		TSVariableBuiltin = { fg = p.red, fmt = cfg.code_style.variables },
	}
end

local diagnostics_error_color = cfg.diagnostics.darker and p.dark_red or p.red
local diagnostics_hint_color = cfg.diagnostics.darker and p.dark_purple or p.grape
local diagnostics_warn_color = cfg.diagnostics.darker and p.dark_yellow or p.yellow
local diagnostics_info_color = cfg.diagnostics.darker and p.dark_cyan or p.cyan
hl.plugins.lsp = {
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
	BufferInactiveMod = { fg = p.light_gray, bg = p.bg1, fmt = "italic" },
	BufferVisible = { fg = p.light_gray, bg = p.bg0 },
	BufferVisibleMod = { fg = p.yellow, bg = p.bg0, fmt = "italic" },
	BufferVisibleIndex = { fg = p.light_gray, bg = p.bg0 },
	BufferVisibleSign = { fg = p.light_gray, bg = p.bg0 },
	BufferVisibleTarget = { fg = p.light_gray, bg = p.bg0 },
}

hl.plugins.cmp = {
	CmpItemAbbr = { fg = p.fg },
	CmpItemAbbrDeprecated = { fg = p.light_gray, fmt = "strikethrough" },
	CmpItemAbbrMatch = { fg = p.cyan },
	CmpItemAbbrMatchFuzzy = { fg = p.cyan, fmt = "underline" },
	CmpItemMenu = { fg = p.light_gray },
	CmpItemKind = { fg = p.grape, fmt = cfg.cmp_itemkind_reverse and "reverse" },
}

hl.plugins.coc = {
	CocErrorSign = hl.plugins.lsp.DiagnosticError,
	CocHintSign = hl.plugins.lsp.DiagnosticHint,
	CocInfoSign = hl.plugins.lsp.DiagnosticInfo,
	CocWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.whichkey = {
	WhichKey = { fg = p.red },
	WhichKeyDesc = { fg = p.blue },
	WhichKeyGroup = { fg = p.orange },
	WhichKeySeparator = { fg = p.green },
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
	HopUnmatched = { fg = p.gray },
}

-- comment
hl.plugins.diffview = {
	DiffviewFilePanelTitle = { fg = p.blue, fmt = "bold" },
	DiffviewFilePanelCounter = { fg = p.grape, fmt = "bold" },
	DiffviewFilePanelFileName = { fg = p.fg },
	DiffviewNormal = hl.common.Normal,
	DiffviewCursorLine = hl.common.CursorLine,
	DiffviewVertSplit = hl.common.VertSplit,
	DiffviewSignColumn = hl.common.SignColumn,
	DiffviewStatusLine = hl.common.StatusLine,
	DiffviewStatusLineNC = hl.common.StatusLineNC,
	DiffviewEndOfBuffer = hl.common.EndOfBuffer,
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

hl.plugins.gitsigns = {
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

hl.plugins.neo_tree = {
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

hl.plugins.neotest = {
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

hl.plugins.nvim_tree = {
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
hl.plugins.telescope = {
	TelescopeBorder = { fg = p.red },
	TelescopePromptBorder = { fg = p.cyan },
	TelescopeResultsBorder = { fg = p.cyan },
	TelescopePreviewBorder = { fg = p.cyan },
	TelescopeMatching = { fg = p.orange, fmt = "bold" },
	TelescopePromptPrefix = { fg = p.green },
	TelescopeSelection = { bg = p.bg2 },
	TelescopeSelectionCaret = { fg = p.yellow },
}

hl.plugins.dashboard = {
	DashboardShortCut = { fg = p.blue },
	DashboardHeader = { fg = p.yellow },
	DashboardCenter = { fg = p.cyan },
	DashboardFooter = { fg = p.dark_red, fmt = "italic" },
}

hl.plugins.outline = {
	FocusedSymbol = { fg = p.grape, bg = p.bg2, fmt = "bold" },
	AerialLine = { fg = p.grape, bg = p.bg2, fmt = "bold" },
}

hl.plugins.navic = {
	NavicText = { fg = p.fg },
	NavicSeparator = { fg = p.light_gray },
}

hl.plugins.ts_rainbow = {
	rainbowcol1 = { fg = p.light_gray },
	rainbowcol2 = { fg = p.yellow },
	rainbowcol3 = { fg = p.blue },
	rainbowcol4 = { fg = p.orange },
	rainbowcol5 = { fg = p.purple },
	rainbowcol6 = { fg = p.green },
	rainbowcol7 = { fg = p.red },
}

hl.plugins.ts_rainbow2 = {
	TSRainbowRed = { fg = p.red },
	TSRainbowYellow = { fg = p.yellow },
	TSRainbowBlue = { fg = p.blue },
	TSRainbowOrange = { fg = p.orange },
	TSRainbowGreen = { fg = p.green },
	TSRainbowViolet = { fg = p.purple },
	TSRainbowCyan = { fg = p.cyan },
}

hl.plugins.rainbow_delimiters = {
	RainbowDelimiterRed = { fg = p.red },
	RainbowDelimiterYellow = { fg = p.yellow },
	RainbowDelimiterBlue = { fg = p.blue },
	RainbowDelimiterOrange = { fg = p.orange },
	RainbowDelimiterGreen = { fg = p.green },
	RainbowDelimiterViolet = { fg = p.purple },
	RainbowDelimiterCyan = { fg = p.cyan },
}

hl.plugins.indent_blankline = {
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

hl.plugins.mini = {
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

hl.langs.c = {
	cInclude = { fg = p.blue },
	cStorageClass = { fg = p.purple },
	cTypedef = { fg = p.purple },
	cDefine = { fg = p.cyan },
	cTSInclude = { fg = p.blue },
	cTSConstant = { fg = p.cyan },
	cTSConstMacro = { fg = p.purple },
	cTSOperator = { fg = p.purple },
}

hl.langs.cpp = {
	cppStatement = { fg = p.grape, fmt = "bold" },
	cppTSInclude = { fg = p.blue },
	cppTSConstant = { fg = p.cyan },
	cppTSConstMacro = { fg = p.purple },
	cppTSOperator = { fg = p.purple },
}

hl.langs.markdown = {
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

hl.langs.php = {
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

hl.langs.scala = {
	scalaNameDefinition = { fg = p.fg },
	scalaInterpolationBoundary = { fg = p.purple },
	scalaInterpolation = { fg = p.purple },
	scalaTypeOperator = { fg = p.red },
	scalaOperator = { fg = p.red },
	scalaKeywordModifier = { fg = p.red, fmt = cfg.code_style.keywords },
}

hl.langs.tex = {
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

hl.langs.vim = {
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
