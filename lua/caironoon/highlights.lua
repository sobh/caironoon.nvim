local p = require('caironoon.palette')
local cfg = vim.g.caironoon_config
local util = require("caironoon.util")

local M = {}
local hl = {langs = {}, plugins = {}}

local function vim_highlights(highlights)
	for group_name, group_settings in pairs(highlights) do
		vim.api.nvim_command(string.format("highlight %s guifg=%s guibg=%s guisp=%s gui=%s", group_name,
		group_settings.fg or "none",
		group_settings.bg or "none",
		group_settings.sp or "none",
		group_settings.fmt or "none"))
	end
end

hl.common = {
	Normal = {fg = p.fg, bg = cfg.transparent and p.none or p.bg0},
	Terminal = {fg = p.fg, bg = cfg.transparent and p.none or p.bg0},
	EndOfBuffer = {fg = cfg.ending_tildes and p.bg2 or p.bg0, bg = cfg.transparent and p.none or p.bg0},
	FoldColumn = {fg = p.fg, bg = cfg.transparent and p.none or p.bg1},
	Folded = {fg = p.fg, bg = cfg.transparent and p.none or p.bg1},
	SignColumn = {fg = p.fg, bg = cfg.transparent and p.none or p.bg0},
	ToolbarLine = {fg = p.fg},
	Cursor = {fmt = "reverse"},
	vCursor = {fmt = "reverse"},
	iCursor = {fmt = "reverse"},
	lCursor = {fmt = "reverse"},
	CursorIM = {fmt = "reverse"},
	CursorColumn = {bg = p.bg1},
	CursorLine = {bg = p.bg1},
	ColorColumn = {bg = p.bg1},
	CursorLineNr = {fg = p.fg},
	LineNr = {fg = p.gray},
	Conceal = {fg = p.gray, bg = p.bg1},
	DiffAdd = {fg = p.none, bg = p.diff_add},
	DiffChange = {fg = p.none, bg = p.diff_change},
	DiffDelete = {fg = p.none, bg = p.diff_delete},
	DiffText = {fg = p.none, bg= p.diff_text},
	DiffAdded = p.green,
	DiffRemoved = p.red,
	DiffFile = p.cyan,
	DiffIndexLine = p.gray,
	Directory = {fg = p.blue},
	ErrorMsg = {fg = p.red, fmt = "bold"},
	WarningMsg = {fg = p.yellow, fmt = "bold"},
	MoreMsg = {fg = p.blue, fmt = "bold"},
	CurSearch = {fg = p.bg0, bg = p.orange},
	IncSearch = {fg = p.bg0, bg = p.orange},
	Search = {fg = p.bg0, bg = p.yellow},
	Substitute = {fg = p.bg0, bg = p.green},
	MatchParen = {fg = p.none, bg = p.gray},
	NonText = {fg = p.gray},
	Whitespace = {fg = p.gray},
	SpecialKey = {fg = p.gray},
	Pmenu = {fg = p.fg, bg = p.bg1},
	PmenuSbar = {fg = p.none, bg = p.bg1},
	PmenuSel = {fg = p.bg0, bg = p.bg_blue},
	WildMenu = {fg = p.bg0, bg = p.blue},
	PmenuThumb = {fg = p.none, bg = p.gray},
	Question = {fg = p.yellow},
	SpellBad = {fg = p.none, fmt = "undercurl", sp = p.red},
	SpellCap = {fg = p.none, fmt = "undercurl", sp = p.yellow},
	SpellLocal = {fg = p.none, fmt = "undercurl", sp = p.blue},
	SpellRare = {fg = p.none, fmt = "undercurl", sp = p.grape},
	StatusLine = {fg = p.fg, bg = p.bg2},
	StatusLineTerm = {fg = p.fg, bg = p.bg2},
	StatusLineNC = {fg = p.gray, bg = p.bg1},
	StatusLineTermNC = {fg = p.gray, bg = p.bg1},
	TabLine = {fg = p.fg, bg = p.bg1},
	TabLineFill = {fg = p.gray, bg = p.bg1},
	TabLineSel =  {fg = p.bg0, bg = p.fg},
	WinSeparator = {fg = p.bg3},
	Visual = {bg = p.bg3},
	VisualNOS = {fg = p.none, bg = p.bg2, fmt = "underline"},
	QuickFixLine = {fg = p.blue, fmt = "underline"},
	Debug = {fg = p.yellow},
	debugPC = {fg = p.bg0, bg = p.green},
	debugBreakpoint = {fg = p.bg0, bg = p.red},
	ToolbarButton = {fg = p.bg0, bg = p.bg_blue},
	FloatBorder = {fg = p.gray, bg = p.bg1},
	NormalFloat = {fg = p.fg, bg = p.bg1},
}

hl.syntax = {
	String = {fg = p.green, fmt = cfg.code_style.strings},
	Character = p.orange,
	Number = p.orange,
	Float = p.orange,
	Boolean = p.orange,
	Type = p.yellow,
	Structure = p.yellow,
	StorageClass = p.yellow,
	Identifier = {fg = p.red, fmt = cfg.code_style.variables},
	Constant = p.cyan,
	PreProc = p.grape,
	PreCondit = p.grape,
	Include = p.grape,
	Keyword = {fg = p.grape, fmt = cfg.code_style.keywords},
	Define = p.grape,
	Typedef = p.yellow,
	Exception = p.grape,
	Conditional = {fg = p.grape, fmt = cfg.code_style.keywords},
	Repeat = {
		fg = p.grape, fmt = cfg.code_style.keywords},
		Statement = p.grape,
		Macro = p.red,
		Error = p.grape,
		Label = p.grape,
		Special = p.red,
		SpecialChar = p.red,
		Function = {fg = p.blue, fmt = cfg.code_style.functions},
		Operator = p.grape,
		Title = p.cyan,
		Tag = p.green,
		Delimiter = p.light_gray,
		Comment = {fg = p.comment, fmt = cfg.code_style.comments},
		SpecialComment = {fg = p.gray, fmt = cfg.code_style.comments},
		Todo = {fg = p.red, fmt = cfg.code_style.comments}
	}

	if vim.fn.has("nvim-0.8") == 1 then
		hl.treesitter = {
			-- nvim-treesitter@0.9.2 and after
			["@annotation"] = p.fg,
			["@attribute"] = p.cyan,
			["@attribute.typescript"] = p.blue,
			["@boolean"] = p.orange,
			["@character"] = p.orange,
			["@comment"] = {fg = p.comment, fmt = cfg.code_style.comments},
			["@comment.todo"] = {fg = p.red, fmt = cfg.code_style.comments},
			["@comment.todo.unchecked"] = {fg = p.red, fmt = cfg.code_style.comments},
			["@comment.todo.checked"] = {fg = p.green, fmt = cfg.code_style.comments},
			["@constant"] = {fg = p.orange, fmt = cfg.code_style.constants},
			["@constant.builtin"] = {fg = p.orange, fmt = cfg.code_style.constants},
			["@constant.macro"] = {fg = p.orange, fmt = cfg.code_style.constants},
			["@constructor"] = {fg = p.yellow, fmt = "bold"},
			["@diff.add"] = p.green,
			["@diff.delete"] = p.red,
			["@error"] = p.fg,
			["@function"] = {fg = p.blue, fmt = cfg.code_style.functions},
			["@function.builtin"] = {fg = p.cyan, fmt = cfg.code_style.functions},
			["@function.macro"] = {fg = p.cyan, fmt = cfg.code_style.functions},
			["@function.method"] = {fg = p.blue, fmt = cfg.code_style.functions},
			["@keyword"] = {fg = p.grape, fmt = cfg.code_style.keywords},
			["@keyword.conditional"] = {fg = p.grape, fmt = cfg.code_style.keywords},
			["@keyword.directive"] = p.grape,
			["@keyword.exception"] = p.grape,
			["@keyword.function"] = {fg = p.grape, fmt = cfg.code_style.functions},
			["@keyword.import"] = p.grape,
			["@keyword.operator"] =  {fg = p.grape, fmt = cfg.code_style.keywords},
			["@keyword.repeat"] = {fg = p.grape, fmt = cfg.code_style.keywords},
			["@label"] = p.red,
			["@markup.emphasis"] = {fg = p.fg, fmt = 'italic'},
			["@markup.environment"] = p.fg,
			["@markup.environment.name"] = p.fg,
			["@markup.heading"] = {fg = p.orange, fmt = 'bold'},
			["@markup.link"] = p.blue,
			["@markup.link.url"] = {fg = p.cyan, fmt = 'underline'},
			["@markup.list"] = p.red,
			["@markup.math"] = p.fg,
			["@markup.raw"] = p.green,
			["@markup.strike"] = {fg = p.fg, fmt = 'strikethrough'},
			["@markup.strong"] = {fg = p.fg, fmt = 'bold'},
			["@markup.underline"] = {fg = p.fg, fmt = 'underline'},
			["@module"] = p.yellow,
			["@none"] = p.fg,
			["@number"] = p.orange,
			["@number.float"] = p.orange,
			["@operator"] = p.fg,
			["@parameter.reference"] = p.fg,
			["@property"] = p.cyan,
			["@punctuation.delimiter"] = p.light_gray,
			["@punctuation.bracket"] = p.light_gray,
			["@string"] = {fg = p.green, fmt = cfg.code_style.strings},
			["@string.regexp"] = {fg = p.orange, fmt = cfg.code_style.strings},
			["@string.escape"] = {fg = p.red, fmt = cfg.code_style.strings},
			["@string.special.symbol"] = p.cyan,
			["@tag"] = p.grape,
			["@tag.attribute"] = p.yellow,
			["@tag.delimiter"] = p.grape,
			["@text"] = p.fg,
			["@note"] = p.fg,
			["@warning"] = p.fg,
			["@danger"] = p.fg,
			["@type"] = p.yellow,
			["@type.builtin"] = p.orange,
			["@variable"] = {fg = p.fg, fmt = cfg.code_style.variables},
			["@variable.builtin"] = {fg = p.red, fmt = cfg.code_style.variables},
			["@variable.member"] = p.cyan,
			["@variable.parameter"] = p.red,
			["@markup.heading.1.markdown"] = {fg = p.red, fmt = "bold"},
			["@markup.heading.2.markdown"] = {fg = p.grape, fmt = "bold"},
			["@markup.heading.3.markdown"] = {fg = p.orange, fmt = "bold"},
			["@markup.heading.4.markdown"] = {fg = p.red, fmt = "bold"},
			["@markup.heading.5.markdown"] = {fg = p.grape, fmt = "bold"},
			["@markup.heading.6.markdown"] = {fg = p.orange, fmt = "bold"},
			["@markup.heading.1.marker.markdown"] = {fg = p.red, fmt = "bold"},
			["@markup.heading.2.marker.markdown"] = {fg = p.grape, fmt = "bold"},
			["@markup.heading.3.marker.markdown"] = {fg = p.orange, fmt = "bold"},
			["@markup.heading.4.marker.markdown"] = {fg = p.red, fmt = "bold"},
			["@markup.heading.5.marker.markdown"] = {fg = p.grape, fmt = "bold"},
			["@markup.heading.6.marker.markdown"] = {fg = p.orange, fmt = "bold"},

			-- Old configuration for nvim-treesiter@0.9.1 and below
			["@conditional"] = {fg = p.grape, fmt = cfg.code_style.keywords},
			["@exception"] = p.grape,
			["@field"] = p.cyan,
			["@float"] = p.orange,
			["@include"] = p.grape,
			["@method"] = {fg = p.blue, fmt = cfg.code_style.functions},
			["@namespace"] = p.yellow,
			["@parameter"] = p.red,
			["@preproc"] = p.grape,
			["@punctuation.special"] = p.red,
			["@repeat"] = {fg = p.grape, fmt = cfg.code_style.keywords},
			["@string.regex"] = {fg = p.orange, fmt = cfg.code_style.strings},
			["@text.strong"] = {fg = p.fg, fmt = 'bold'},
			["@text.emphasis"] = {fg = p.fg, fmt = 'italic'},
			["@text.underline"] = {fg = p.fg, fmt = 'underline'},
			["@text.strike"] = {fg = p.fg, fmt = 'strikethrough'},
			["@text.title"] = {fg = p.orange, fmt = 'bold'},
			["@text.literal"] = p.green,
			["@text.uri"] = {fg = p.cyan, fmt = 'underline'},
			["@text.todo"] = {fg = p.red, fmt = cfg.code_style.comments},
			["@text.todo.unchecked"] = {fg = p.red, fmt = cfg.code_style.comments},
			["@text.todo.checked"] = {fg = p.green, fmt = cfg.code_style.comments},
			["@text.math"] = p.fg,
			["@text.reference"] = p.blue,
			["@text.environment"] = p.fg,
			["@text.environment.name"] = p.fg,
			["@text.diff.add"] = p.green,
			["@text.diff.delete"] = p.red,
		}
		if vim.fn.has("nvim-0.9") == 1 then
			hl.lsp = {
				["@lsp.type.comment"] = hl.treesitter[ "@comment"],
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
			TSAnnotation = p.fg,
			TSAttribute = p.cyan,
			TSBoolean = p.orange,
			TSCharacter = p.orange,
			TSComment = {fg = p.comment, fmt = cfg.code_style.comments},
			TSConditional = {fg = p.grape, fmt = cfg.code_style.keywords},
			TSConstant = p.orange,
			TSConstBuiltin = p.orange,
			TSConstMacro = p.orange,
			TSConstructor = {fg = p.yellow, fmt = "bold"},
			TSError = p.fg,
			TSException = p.grape,
			TSField = p.cyan,
			TSFloat = p.orange,
			TSFunction = {fg = p.blue, fmt = cfg.code_style.functions},
			TSFuncBuiltin = {fg = p.cyan, fmt = cfg.code_style.functions},
			TSFuncMacro = {fg = p.cyan, fmt = cfg.code_style.functions},
			TSInclude = p.grape,
			TSKeyword = {fg = p.grape, fmt = cfg.code_style.keywords},
			TSKeywordFunction = {fg = p.grape, fmt = cfg.code_style.functions},
			TSKeywordOperator =  {fg = p.grape, fmt = cfg.code_style.keywords},
			TSLabel = p.red,
			TSMethod = {fg = p.blue, fmt = cfg.code_style.functions},
			TSNamespace = p.yellow,
			TSNone = p.fg,
			TSNumber = p.orange,
			TSOperator = p.fg,
			TSParameter = p.red,
			TSParameterReference = p.fg,
			TSProperty = p.cyan,
			TSPunctDelimiter = p.light_gray,
			TSPunctBracket = p.light_gray,
			TSPunctSpecial = p.red,
			TSRepeat = {fg = p.grape, fmt = cfg.code_style.keywords},
			TSString = {fg = p.green, fmt = cfg.code_style.strings},
			TSStringRegex = {fg = p.orange, fmt = cfg.code_style.strings},
			TSStringEscape = {fg = p.red, fmt = cfg.code_style.strings},
			TSSymbol = p.cyan,
			TSTag = p.grape,
			TSTagDelimiter = p.grape,
			TSText = p.fg,
			TSStrong = {fg = p.fg, fmt = 'bold'},
			TSEmphasis = {fg = p.fg, fmt = 'italic'},
			TSUnderline = {fg = p.fg, fmt = 'underline'},
			TSStrike = {fg = p.fg, fmt = 'strikethrough'},
			TSTitle = {fg = p.orange, fmt = 'bold'},
			TSLiteral = p.green,
			TSURI = {fg = p.cyan, fmt = 'underline'},
			TSMath = p.fg,
			TSTextReference = p.blue,
			TSEnvironment = p.fg,
			TSEnvironmentName = p.fg,
			TSNote = p.fg,
			TSWarning = p.fg,
			TSDanger = p.fg,
			TSType = p.yellow,
			TSTypeBuiltin = p.orange,
			TSVariable = {fg = p.fg, fmt = cfg.code_style.variables},
			TSVariableBuiltin = {fg = p.red, fmt = cfg.code_style.variables},
		}
	end

	local diagnostics_error_color = cfg.diagnostics.darker and p.dark_red or p.red
	local diagnostics_hint_color  = cfg.diagnostics.darker and p.dark_purple or p.grape
	local diagnostics_warn_color  = cfg.diagnostics.darker and p.dark_yellow or p.yellow
	local diagnostics_info_color  = cfg.diagnostics.darker and p.dark_cyan or p.cyan
	hl.plugins.lsp = {
		LspCxxHlGroupEnumConstant = p.orange,
		LspCxxHlGroupMemberVariable = p.orange,
		LspCxxHlGroupNamespace = p.blue,
		LspCxxHlSkippedRegion = p.gray,
		LspCxxHlSkippedRegionBeginEnd = p.red,

		DiagnosticError = {fg = p.red},
		DiagnosticHint  = {fg = p.grape},
		DiagnosticInfo  = {fg = p.cyan},
		DiagnosticWarn  = {fg = p.yellow},

		DiagnosticVirtualTextError = { bg = cfg.diagnostics.background and util.darken(diagnostics_error_color, 0.1, p.bg0) or p.none,
		fg = diagnostics_error_color },
		DiagnosticVirtualTextWarn = { bg = cfg.diagnostics.background and util.darken(diagnostics_warn_color, 0.1, p.bg0) or p.none,
		fg = diagnostics_warn_color },
		DiagnosticVirtualTextInfo = { bg = cfg.diagnostics.background and util.darken(diagnostics_info_color, 0.1, p.bg0) or p.none,
		fg = diagnostics_info_color },
		DiagnosticVirtualTextHint = { bg = cfg.diagnostics.background and util.darken(diagnostics_hint_color, 0.1, p.bg0) or p.none,
		fg = diagnostics_hint_color },

		DiagnosticUnderlineError = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = p.red},
		DiagnosticUnderlineHint = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = p.grape},
		DiagnosticUnderlineInfo = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = p.blue},
		DiagnosticUnderlineWarn = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = p.yellow},

		LspReferenceText = { bg = p.bg2 },
		LspReferenceWrite = { bg = p.bg2 },
		LspReferenceRead = { bg = p.bg2 },

		LspCodeLens = { fg = p.comment, fmt = cfg.code_style.comments },
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
		CmpItemAbbr = p.fg,
		CmpItemAbbrDeprecated = { fg = p.light_gray, fmt = "strikethrough" },
		CmpItemAbbrMatch = p.cyan,
		CmpItemAbbrMatchFuzzy = { fg = p.cyan, fmt = "underline" },
		CmpItemMenu = p.light_gray,
		CmpItemKind = { fg = p.grape, fmt = cfg.cmp_itemkind_reverse and "reverse" },
	}

	hl.plugins.coc = {
		CocErrorSign = hl.plugins.lsp.DiagnosticError,
		CocHintSign = hl.plugins.lsp.DiagnosticHint,
		CocInfoSign = hl.plugins.lsp.DiagnosticInfo,
		CocWarningSign = hl.plugins.lsp.DiagnosticWarn,
	}

	hl.plugins.whichkey = {
		WhichKey = p.red,
		WhichKeyDesc = p.blue,
		WhichKeyGroup = p.orange,
		WhichKeySeparator = p.green
	}

	hl.plugins.gitgutter = {
		GitGutterAdd = {fg = p.green},
		GitGutterChange = {fg = p.blue},
		GitGutterDelete = {fg = p.red},
	}

	hl.plugins.hop = {
		HopNextKey = {fg = p.red, fmt = "bold"},
		HopNextKey1 = {fg = p.cyan, fmt = "bold"},
		HopNextKey2 = {fg = util.darken(p.blue, 0.7)},
		HopUnmatched = p.gray,
	}

	-- comment
	hl.plugins.diffview = {
		DiffviewFilePanelTitle = {fg = p.blue, fmt = "bold"},
		DiffviewFilePanelCounter = {fg = p.grape, fmt = "bold"},
		DiffviewFilePanelFileName = p.fg,
		DiffviewNormal = hl.common.Normal,
		DiffviewCursorLine = hl.common.CursorLine,
		DiffviewVertSplit = hl.common.VertSplit,
		DiffviewSignColumn = hl.common.SignColumn,
		DiffviewStatusLine = hl.common.StatusLine,
		DiffviewStatusLineNC = hl.common.StatusLineNC,
		DiffviewEndOfBuffer = hl.common.EndOfBuffer,
		DiffviewFilePanelRootPath = p.gray,
		DiffviewFilePanelPath = p.gray,
		DiffviewFilePanelInsertions = p.green,
		DiffviewFilePanelDeletions = p.red,
		DiffviewStatusAdded = p.green,
		DiffviewStatusUntracked = p.blue,
		DiffviewStatusModified = p.blue,
		DiffviewStatusRenamed = p.blue,
		DiffviewStatusCopied = p.blue,
		DiffviewStatusTypeChange = p.blue,
		DiffviewStatusUnmerged = p.blue,
		DiffviewStatusUnknown = p.red,
		DiffviewStatusDeleted = p.red,
		DiffviewStatusBroken = p.red
	}

	hl.plugins.gitsigns = {
		GitSignsAdd = p.green,
		GitSignsAddLn = p.green,
		GitSignsAddNr = p.green,
		GitSignsChange = p.blue,
		GitSignsChangeLn = p.blue,
		GitSignsChangeNr = p.blue,
		GitSignsDelete = p.red,
		GitSignsDeleteLn = p.red,
		GitSignsDeleteNr = p.red
	}

	hl.plugins.neo_tree = {
		NeoTreeNormal = { fg = p.fg, bg = cfg.transparent and p.none or p.bg_d },
		NeoTreeNormalNC = { fg = p.fg, bg = cfg.transparent and p.none or p.bg_d },
		NeoTreeVertSplit = { fg = p.bg1, bg = cfg.transparent and p.none or p.bg1 },
		NeoTreeWinSeparator = { fg = p.bg1, bg = cfg.transparent and p.none or p.bg1 },
		NeoTreeEndOfBuffer = { fg = cfg.ending_tildes and p.bg2 or p.bg_d, bg = cfg.transparent and p.none or p.bg_d },
		NeoTreeRootName = { fg = p.orange, fmt = "bold" },
		NeoTreeGitAdded = p.green,
		NeoTreeGitDeleted = p.red,
		NeoTreeGitModified = p.yellow,
		NeoTreeGitConflict = { fg = p.red, fmt = "bold,italic" },
		NeoTreeGitUntracked = { fg = p.red, fmt = "italic" },
		NeoTreeIndentMarker = p.gray,
		NeoTreeSymbolicLinkTarget = p.grape,
	}

	hl.plugins.neotest = {
		NeotestAdapterName = { fg = p.grape, fmt = "bold" },
		NeotestDir = p.cyan,
		NeotestExpandMarker = p.gray,
		NeotestFailed = p.red,
		NeotestFile = p.cyan,
		NeotestFocused = { fmt = "bold,italic" },
		NeotestIndent = p.gray,
		NeotestMarked = { fg = p.orange, fmt = "bold" },
		NeotestNamespace = p.blue,
		NeotestPassed = p.green,
		NeotestRunning = p.yellow,
		NeotestWinSelect = { fg = p.cyan, fmt = "bold" },
		NeotestSkipped = p.light_gray,
		NeotestTarget = p.grape,
		NeotestTest = p.fg,
		NeotestUnknown = p.light_gray,
	}

	hl.plugins.nvim_tree = {
		NvimTreeNormal = { fg = p.fg, bg = cfg.transparent and p.none or p.bg_d },
		NvimTreeVertSplit = { fg = p.bg_d, bg = cfg.transparent and p.none or p.bg_d },
		NvimTreeEndOfBuffer = { fg = cfg.ending_tildes and p.bg2 or p.bg_d, bg = cfg.transparent and p.none or p.bg_d },
		NvimTreeRootFolder = { fg = p.orange, fmt = "bold" },
		NvimTreeGitDirty = p.yellow,
		NvimTreeGitNew = p.green,
		NvimTreeGitDeleted = p.red,
		NvimTreeSpecialFile = { fg = p.yellow, fmt = "underline" },
		NvimTreeIndentMarker = p.fg,
		NvimTreeImageFile = { fg = p.dark_purple },
		NvimTreeSymlink = p.grape,
		NvimTreeFolderName = p.blue,
	}
	hl.plugins.telescope = {
		TelescopeBorder = p.red,
		TelescopePromptBorder = p.cyan,
		TelescopeResultsBorder = p.cyan,
		TelescopePreviewBorder = p.cyan,
		TelescopeMatching = { fg = p.orange, fmt = "bold" },
		TelescopePromptPrefix = p.green,
		TelescopeSelection =  { bg =p.bg2 },
		TelescopeSelectionCaret = p.yellow
	}

	hl.plugins.dashboard = {
		DashboardShortCut = p.blue,
		DashboardHeader = p.yellow,
		DashboardCenter = p.cyan,
		DashboardFooter = { fg = p.dark_red, fmt = "italic"}
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
		rainbowcol1 = p.light_gray,
		rainbowcol2 = p.yellow,
		rainbowcol3 = p.blue,
		rainbowcol4 = p.orange,
		rainbowcol5 = p.grape,
		rainbowcol6 = p.green,
		rainbowcol7 = p.red
	}

	hl.plugins.ts_rainbow2 = {
		TSRainbowRed = p.red,
		TSRainbowYellow = p.yellow,
		TSRainbowBlue = p.blue,
		TSRainbowOrange = p.orange,
		TSRainbowGreen = p.green,
		TSRainbowViolet = p.grape,
		TSRainbowCyan = p.cyan,
	}

	hl.plugins.rainbow_delimiters = {
		RainbowDelimiterRed = p.red,
		RainbowDelimiterYellow = p.yellow,
		RainbowDelimiterBlue = p.blue,
		RainbowDelimiterOrange = p.orange,
		RainbowDelimiterGreen = p.green,
		RainbowDelimiterViolet = p.grape,
		RainbowDelimiterCyan = p.cyan,
	}

	hl.plugins.indent_blankline = {
		IndentBlanklineIndent1 = p.blue,
		IndentBlanklineIndent2 = p.green,
		IndentBlanklineIndent3 = p.cyan,
		IndentBlanklineIndent4 = p.light_gray,
		IndentBlanklineIndent5 = p.grape,
		IndentBlanklineIndent6 = p.red,
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
		MiniStarterHeader = p.yellow,
		MiniStarterInactive = { fg = p.comment, fmt = cfg.code_style.comments },
		MiniStarterItem = { fg = p.fg, bg = cfg.transparent and p.none or p.bg0 },
		MiniStarterItemBullet = { fg = p.gray },
		MiniStarterItemPrefix = { fg = p.yellow },
		MiniStarterSection = p.light_gray,
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
		MiniTablineTabpagesection = { fg = p.bg0, bg = p.yellow },
		MiniTablineVisible = { fg = p.light_gray, bg = p.bg0 },

		MiniTestEmphasis = { fmt = "bold" },
		MiniTestFail = { fg = p.red, fmt = "bold" },
		MiniTestPass = { fg = p.green, fmt = "bold" },

		MiniTrailspace = { bg = p.red },
	}

	hl.langs.c = {
		cInclude = p.blue,
		cStorageClass = p.grape,
		cTypedef = p.grape,
		cDefine = p.cyan,
		cTSInclude = p.blue,
		cTSConstant = p.cyan,
		cTSConstMacro = p.grape,
		cTSOperator = p.grape,
	}

	hl.langs.cpp = {
		cppStatement = { fg = p.grape, fmt = "bold" },
		cppTSInclude = p.blue,
		cppTSConstant = p.cyan,
		cppTSConstMacro = p.grape,
		cppTSOperator = p.grape,
	}

	hl.langs.markdown = {
		markdownBlockquote = p.gray,
		markdownBold = {fg = p.none, fmt = "bold"},
		markdownBoldDelimiter = p.gray,
		markdownCode = p.green,
		markdownCodeBlock = p.green,
		markdownCodeDelimiter = p.yellow,
		markdownH1 = {fg = p.red, fmt = "bold"},
		markdownH2 = {fg = p.grape, fmt = "bold"},
		markdownH3 = {fg = p.orange, fmt = "bold"},
		markdownH4 = {fg = p.red, fmt = "bold"},
		markdownH5 = {fg = p.grape, fmt = "bold"},
		markdownH6 = {fg = p.orange, fmt = "bold"},
		markdownHeadingDelimiter = p.gray,
		markdownHeadingRule = p.gray,
		markdownId = p.yellow,
		markdownIdDeclaration = p.red,
		markdownItalic = {fg = p.none, fmt = "italic"},
		markdownItalicDelimiter = {fg = p.gray, fmt = "italic"},
		markdownLinkDelimiter = p.gray,
		markdownLinkText = p.red,
		markdownLinkTextDelimiter = p.gray,
		markdownListMarker = p.red,
		markdownOrderedListMarker = p.red,
		markdownRule = p.grape,
		markdownUrl = {fg = p.blue, fmt = "underline"},
		markdownUrlDelimiter = p.gray,
		markdownUrlTitleDelimiter = p.green
	}

	hl.langs.php = {
		phpFunctions = {fg = p.fg, fmt = cfg.code_style.functions},
		phpMethods = p.cyan,
		phpStructure = p.grape,
		phpOperator = p.grape,
		phpMemberSelector = p.fg,
		phpVarSelector = {fg = p.orange, fmt = cfg.code_style.variables},
		phpIdentifier = {fg = p.orange, fmt = cfg.code_style.variables},
		phpBoolean = p.cyan,
		phpNumber = p.orange,
		phpHereDoc = p.green,
		phpNowDoc = p.green,
		phpSCKeyword = {fg = p.grape, fmt = cfg.code_style.keywords},
		phpFCKeyword = {fg = p.grape, fmt = cfg.code_style.keywords},
		phpRegion = p.blue
	}

	hl.langs.scala = {
		scalaNameDefinition = p.fg,
		scalaInterpolationBoundary = p.grape,
		scalaInterpolation = p.grape,
		scalaTypeOperator = p.red,
		scalaOperator = p.red,
		scalaKeywordModifier = {fg = p.red, fmt = cfg.code_style.keywords},
	}

	hl.langs.tex = {
		latexTSInclude = p.blue,
		latexTSFuncMacro = {fg = p.fg, fmt = cfg.code_style.functions},
		latexTSEnvironment = { fg = p.cyan, fmt = "bold" },
		latexTSEnvironmentName = p.yellow,
		Cyan = p.cyan,
		texEnvArgName = p.yellow,
		latexTSTitle = p.green,
		latexTSType = p.blue,
		latexTSMath   = p.orange,
		texMathZoneX  = p.orange,
		texMathZoneXX = p.orange,
		texMathDelimZone = p.light_gray,
		texMathDelim = p.grape,
		texMathOper = p.red,
		texCmd = p.grape,
		texCmdPart = p.blue,
		texCmdPackage = p.blue,
		texPgfType = p.yellow,
	}

	hl.langs.vim = {
		vimOption = p.red,
		vimSetEqual = p.yellow,
		vimMap = p.grape,
		vimMapModKey = p.orange,
		vimNotation = p.red,
		vimMapLhs = p.fg,
		vimMapRhs = p.blue,
		vimVar = {fg = p.fg, fmt = cfg.code_style.variables},
		vimCommentTitle = {fg = p.comment, fmt = cfg.code_style.comments},
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
		for _, group in pairs(hl.langs) do vim_highlights(group) end
		for _, group in pairs(hl.plugins) do vim_highlights(group) end

		-- user defined highlights: vim_highlights function cannot be used because it sets an attribute to none if not specified
		local function replace_color(prefix, color_name)
			if not color_name then return "" end
			if color_name:sub(1, 1) == '$' then
				local name = color_name:sub(2, -1)
				color_name = p[name]
				if not color_name then
					vim.schedule(function()
						vim.notify('caironoon.nvim: unknown color "' .. name .. '"', vim.log.levels.ERROR, { title = "caironoon.nvim" })
					end)
					return ""
				end
			end
			return prefix .. "=" .. color_name
		end

		for group_name, group_settings in pairs(vim.g.caironoon_config.highlights) do
			vim.api.nvim_command(string.format("highlight %s %s %s %s %s", group_name,
			replace_color("guifg", group_settings.fg),
			replace_color("guibg", group_settings.bg),
			replace_color("guisp", group_settings.sp),
			replace_color("gui", group_settings.fmt)))
		end
	end

	return M
