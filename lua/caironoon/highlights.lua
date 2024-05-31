local p = require("caironoon.palette")
local util = require("caironoon.util")
local opts = require("caironoon.config").options

local M = {}
local groups = { langs = {}, plugins = {} }
local bg_is_dark = vim.opt.background:get() == 'dark';

-- stylua: ignore
-- The builtin highlighting groups.
-- :help highlight-groups
groups.common = {
	Normal = {
		fg = p.fg.base, bg = opts.transparent and p.none or p.bg.base[1],
		ctermfg = p.term.fg.base, ctermbg = p.term.bg[1],
	},
	Terminal = { link = "Normal" },
	EndOfBuffer = {
		fg = opts.ending_tildes and p.bg.base[3] or p.bg.base[1], bg = opts.transparent and p.none or p.bg.base[1],
		ctermfg = opts.ending_tildes and p.term.bg[3] or p.term.bg[1], ctermbg =  p.term.bg[1]
	},
	Folded = {
		fg = p.fg.base, bg = opts.transparent and p.none or p.bg.base[2],
		ctermfg = p.term.fg.base, ctermbg=p.term.bg[2],
	},
	FoldColumn  = { link = "Folded" },
	SignColumn  = {
		fg = p.fg.base, bg = opts.transparent and p.none or p.bg.base[1],
		ctermfg = p.term.fg.base, ctermbg = p.term.bg[1],
	},

	ToolbarLine  = { fg = p.fg.base, ctermfg = p.term.fg.base},
	Cursor       = { fg=p.bg.base[1], bg=p.fg.base },
	vCursor      = { link = "Cursor" },
	iCursor      = { link = "Cursor" },
	lCursor      = { link = "Cursor" },
	CursorIM     = { link = "Cursor" },
	CursorLine   = { bg = p.bg.base[2], ctermbg = p.term.bg[2] },
	CursorColumn = { link = "CursorLine" },
	ColorColumn  = { link = "CursorLine" },
	CursorLineNr = {
		fg = p.fg.base, bold=true,
		ctermfg = p.term.fg.base,
	},
	LineNr = { fg = p.fg.gray, ctermfg = p.term.fg.gray },
	Conceal = {
		fg = p.fg.gray, bg = p.bg.base[2],
		ctermfg=p.term.fg.base, ctermbg=p.term.bg[2],
	},

	DiffAdd = {
		fg = p.none, bg = p.syntax.diff.add.bg,
		ctermfg = p.none, ctermbg= p.term.syntax.diff.add.bg,
	},
	DiffChange = {
		fg = p.none, bg = p.syntax.diff.change.bg,
		ctermfg = p.none, ctermbg= p.term.syntax.diff.change.bg,
	},
	DiffDelete = {
		fg = p.none, bg = p.syntax.diff.delete.bg,
		ctermfg = p.none, ctermbg= p.term.syntax.diff.delete.bg,
	},
	DiffText   = {
		fg = p.none, bg = p.syntax.diff.text.bg,
		ctermfg = p.none, ctermbg= p.term.syntax.diff.text.bg,
	},

	Directory        = { fg = p.fg.blue },
	ErrorMsg         = { fg = p.fg.red, bold = true },
	WarningMsg       = { fg = p.fg.yellow, bold = true },
	MoreMsg          = { fg = p.fg.blue, bold = true },
	Search           = { fg = p.fg.yellow, bg=p.bg.base[1], reverse=true },
	CurSearch        = { fg = p.fg.orange, bg=p.bg.base[1], reverse=true },
	IncSearch        = { link="CurSearch" },
	Substitute       = { fg = p.bg.base[1], bg = p.fg.green },
	MatchParen       = { fg = p.none, bg = p.fg.gray },
	NonText          = { fg = p.fg.gray },
	Whitespace       = { fg = p.bg.base[2] },
	SpecialKey       = { fg = p.fg.gray },
	Pmenu            = { fg = p.fg.base, bg = p.bg.base[2] },
	PmenuSbar        = { fg = p.none, bg = p.bg.base[2] },
	PmenuSel         = { fg = p.fg.blue, bg=p.bg.base[1], reverse=true },
	WildMenu         = { fg = p.bg.base[1], bg = p.fg.blue },
	PmenuThumb       = { fg = p.none, bg = p.fg.gray },
	Question         = { fg = p.fg.yellow },
	SpellBad         = { fg = p.none, undercurl = true, sp = p.fg.red },
	SpellCap         = { fg = p.none, undercurl = true, sp = p.fg.yellow },
	SpellLocal       = { fg = p.none, undercurl = true, sp = p.fg.blue },
	SpellRare        = { fg = p.none, undercurl = true, sp = p.fg.purple },
	StatusLine       = { fg = p.fg.base, bg = p.bg.base[3] },
	StatusLineTerm   = { fg = p.fg.base, bg = p.bg.base[3] },
	StatusLineNC     = { fg = p.fg.gray, bg = p.bg.base[2] },
	StatusLineTermNC = { fg = p.fg.gray, bg = p.bg.base[2] },
	TabLine          = { fg = p.fg.base, bg = p.bg.base[2] },
	TabLineFill      = { fg = p.fg.gray, bg = p.bg.base[2] },
	TabLineSel       = { fg = p.bg.base[1], bg = p.fg.base },
	WinSeparator     = { fg = p.bg.base[4] },
	Visual           = { bg = p.bg.base[4] },
	VisualNOS        = { fg = p.none, bg = p.bg.base[3], underline = true },
	QuickFixLine     = { fg = p.fg.blue, underline = true },
	Debug            = { fg = p.fg.yellow },
	debugPC          = { fg = p.bg.base[1], bg = p.fg.green },
	debugBreakpoint  = { fg = p.bg.base[1], bg = p.fg.red },
	ToolbarButton    = { fg = p.bg.base[1], bg = p.bg.blue },
	FloatBorder      = { fg = p.fg.gray, bg = p.bg.base[2] },
	NormalFloat      = { fg = p.fg.base, bg = p.bg.base[2] },
	Title            = { fg = p.fg.cyan },

}

-- stylua: ignore
groups.syntax = {
	-- :help group-name
	Comment        = { fg = p.syntax.comment },       -- A Comment

	Constant       = { fg = p.fg.cyan },                 -- Any Constant
	String         = { fg = p.fg.green },                -- A string literal "like this"
	Character      = { fg = p.fg.orange },               -- A character constant: 'c', '\n'
	Number         = { fg = p.fg.orange },               -- A number constant: 233, 0xff
	Boolean        = { fg = p.fg.orange },               -- A boolean constant: TRUE, false
	Float          = { fg = p.fg.orange },               -- A floating point constant: 1.3e10

	Identifier     = { fg = p.fg.red },                  -- Any variable name
	Function       = { fg = p.fg.blue, bold = true },    -- Function name

	Statement      = { fg = p.fg.purple, italic = true }, -- Any statement
	Conditional    = { link = "Statement" },          -- if, then, else, endif, switch, etc.
	Repeat         = { link = "Statement" },          -- for, to, while, etc.
	Label          = { link = "Statement" },          -- case, default, etc.
	Operator       = { link = "Statement" },          -- "sizeof", "+", "*", etc.
	Keyword        = { link = "Statement" },          -- Any other keyword
	Exception      = { link = "Statement" },          -- try, catch, throw

	PreProc        = { fg = p.fg.purple },                -- Generic Preprocessor
	Include        = { link = "PreProc" },            -- Preprocessor #include
	Define         = { link = "PreProc" },            -- Preprocessor #define
	Macro          = { fg = p.fg.red },                  -- Same as Define
	PreCondit      = { link = "PreProc" },            -- Preprocessor #if, #else, #endif, etc.

	Type           = { fg = p.fg.yellow },               -- int, long, char, etc.
	StorageClass   = { link = "Type" },               -- static, register, volatile, etc.
	Structure      = { link = "Type" },               -- struct, union, enum, etc.
	Typedef        = { link = "Type" },               -- A typedef

	Special        = { fg = p.fg.red },                   -- any special symbol
	SpecialChar    = { link = "Special" },             -- special character in a constant
	Tag            = { fg = p.fg.green, underline=true }, -- you can use CTRL-] on this
	Delimiter      = { fg = p.fg.gray },            -- character that needs attention
	SpecialComment = { fg = p.syntax.comment },        -- special things inside a comment
	Debug          = { fg = p.fg.orange },                -- debugging statements

	Underlined     = { fg = p.fg.violet, underline = true }, -- text that stands out, HTML links

	Ignore         = { fg = p.fg.base },     -- left blank, hidden  |hl-Ignore|

	Error          = { fg = p.fg.purple },  -- any erroneous construct

	Todo           = { fg = p.fg.orange }, -- TODO, FIXME, XXX etc
}

groups.treesitter = {
	["@annotation"] = { fg = p.fg.base },
	["@attribute"] = { fg = p.fg.cyan },
	["@attribute.typescript"] = { fg = p.fg.blue },
	["@boolean"] = { fg = p.fg.orange },
	["@character"] = { fg = p.fg.orange },
	["@comment"] = { link = "Comment" },
	["@comment.todo"] = { link = "Todo" },
	["@comment.todo.unchecked"] = { fg = p.fg.red },
	["@comment.todo.checked"] = { fg = p.fg.green },
	["@constant"] = { link = "Constant" },
	["@constant.builtin"] = { link = "Constant" },
	["@constant.macro"] = { link = "Constant" },
	["@constructor"] = { fg = p.fg.yellow, bold = true },
	["@diff.add"] = { fg = p.fg.green },
	["@diff.delete"] = { fg = p.fg.red },
	["@error"] = { fg = p.fg.base },

	["@function"] = { link = "Function" },
	["@function.builtin"] = { fg = p.fg.cyan, bold = true },
	["@function.macro"] = { fg = p.fg.teal },
	["@function.method"] = { fg = p.fg.indigo },

	["@keyword"] = { link = "Keyword" },
	["@keyword.conditional"] = { link = "Keyword" },
	["@keyword.directive"] = { link = "Keyword" },
	["@keyword.exception"] = { link = "Keyword" },
	["@keyword.function"] = { link = "Keyword" },
	["@keyword.import"] = { link = "Keyword" },
	["@keyword.operator"] = { link = "Keyword" },
	["@keyword.repeat"] = { link = "Keyword" },

	["@label"] = { fg = p.fg.red },
	["@markup.emphasis"] = { fg = p.fg.base, italic = true },
	["@markup.environment"] = { fg = p.fg.base },
	["@markup.environment.name"] = { fg = p.fg.base },
	["@markup.heading"] = { fg = p.fg.orange, bold = true },
	["@markup.link"] = { fg = p.fg.blue },
	["@markup.link.url"] = { fg = p.fg.cyan, underline = true },
	["@markup.list"] = { fg = p.fg.red },
	["@markup.math"] = { fg = p.fg.base },
	["@markup.raw"] = { fg = p.fg.green },
	["@markup.strike"] = { fg = p.fg.base, strikethrough = true },
	["@markup.strong"] = { fg = p.fg.base, bold = true },
	["@markup.underline"] = { fg = p.fg.base, underline = true },
	["@module"] = { fg = p.fg.yellow },
	["@none"] = { fg = p.fg.base },
	["@number"] = { fg = p.fg.orange },
	["@number.float"] = { fg = p.fg.orange },
	["@operator"] = { fg = p.fg.base },
	["@parameter.reference"] = { fg = p.fg.base },
	["@property"] = { fg = p.fg.cyan },
	["@punctuation.delimiter"] = { fg = p.fg.gray },
	["@punctuation.bracket"] = { fg = p.fg.gray },
	["@string"] = { fg = p.fg.green },
	["@string.regexp"] = { fg = p.fg.orange },
	["@string.escape"] = { fg = p.fg.red },
	["@string.special.symbol"] = { fg = p.fg.cyan },
	["@tag"] = { fg = p.fg.purple },
	["@tag.attribute"] = { fg = p.fg.yellow },
	["@tag.delimiter"] = { fg = p.fg.purple },
	["@text"] = { fg = p.fg.base },
	["@note"] = { fg = p.fg.green },
	["@warning"] = { fg = p.fg.base },
	["@danger"] = { fg = p.fg.base },
	["@type"] = { fg = p.fg.yellow },
	["@type.builtin"] = { fg = p.fg.orange },
	["@variable"] = { fg = p.fg.base },
	["@variable.builtin"] = { fg = p.fg.red },
	["@variable.member"] = { fg = p.fg.cyan },
	["@variable.parameter"] = { fg = p.fg.red },
	["@markup.heading.1.markdown"] = { fg = p.fg.red, bold = true },
	["@markup.heading.2.markdown"] = { fg = p.fg.purple, bold = true },
	["@markup.heading.3.markdown"] = { fg = p.fg.orange, bold = true },
	["@markup.heading.4.markdown"] = { fg = p.fg.red, bold = true },
	["@markup.heading.5.markdown"] = { fg = p.fg.purple, bold = true },
	["@markup.heading.6.markdown"] = { fg = p.fg.orange, bold = true },
	["@markup.heading.1.marker.markdown"] = { fg = p.fg.red, bold = true },
	["@markup.heading.2.marker.markdown"] = { fg = p.fg.purple, bold = true },
	["@markup.heading.3.marker.markdown"] = { fg = p.fg.orange, bold = true },
	["@markup.heading.4.marker.markdown"] = { fg = p.fg.red, bold = true },
	["@markup.heading.5.marker.markdown"] = { fg = p.fg.purple, bold = true },
	["@markup.heading.6.marker.markdown"] = { fg = p.fg.orange, bold = true },
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

	DiagnosticVirtualTextError = { fg=p.syntax.diag.error.fg, bg=p.syntax.diag.error.bg },
	DiagnosticVirtualTextHint  = { fg=p.syntax.diag.hint.fg,  bg=p.syntax.diag.hint.bg },
	DiagnosticVirtualTextInfo  = { fg=p.syntax.diag.info.fg,  bg=p.syntax.diag.info.bg },
	DiagnosticVirtualTextWarn  = { fg=p.syntax.diag.warning.fg, bg=p.syntax.diag.warning.bg },

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

		LspReferenceText  = { bg = p.bg.base[3] },
		LspReferenceWrite = { bg = p.bg.base[3] },
		LspReferenceRead  = { bg = p.bg.base[3] },

		LspCodeLens = { fg = p.fg.gray },
		LspCodeLensSeparator = { fg = p.fg.gray },

		LspCxxHlGroupEnumConstant = { fg = p.fg.orange },
		LspCxxHlGroupMemberVariable = { fg = p.fg.orange },
		LspCxxHlGroupNamespace = { fg = p.fg.blue },
		LspCxxHlSkippedRegion = { fg = p.fg.gray },
		LspCxxHlSkippedRegionBeginEnd = { fg = p.fg.red },
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
		BufferCurrent       = { bold = true },
		BufferCurrentMod    = { fg = p.fg.orange, bold = true, italic = true },
		BufferCurrentSign   = { fg = p.fg.purple },
		BufferInactiveMod   = { fg = p.fg.gray, bg = p.bg.base[2], italic = true },
		BufferVisible       = { fg = p.fg.gray, bg = p.bg.base[1] },
		BufferVisibleMod    = { fg = p.fg.yellow, bg = p.bg.base[1], italic = true },
		BufferVisibleIndex  = { fg = p.fg.gray, bg = p.bg.base[1] },
		BufferVisibleSign   = { fg = p.fg.gray, bg = p.bg.base[1] },
		BufferVisibleTarget = { fg = p.fg.gray, bg = p.bg.base[1] },
	},

	cmp = {
		CmpItemAbbr           = { fg = p.fg.base },
		CmpItemAbbrDeprecated = { fg = p.fg.gray, strikethrough = true },
		CmpItemAbbrMatch      = { fg = p.fg.cyan },
		CmpItemAbbrMatchFuzzy = { fg = p.fg.cyan, underline = true },
		CmpItemMenu           = { fg = p.fg.gray },
		CmpItemKind           = { fg = p.fg.purple, reverse = true },
	},

	whichkey = {
		WhichKey          = { fg = p.fg.red },
		WhichKeyDesc      = { fg = p.fg.blue },
		WhichKeyGroup     = { fg = p.fg.orange },
		WhichKeySeparator = { fg = p.fg.green },
	},

	gitgutter = {
		-- GitGutterAdd = { fg = p.fg.green },
		-- GitGutterChange = { fg = p.fg.blue },
		-- GitGutterDelete = { fg = p.fg.red },
	},

	hop = {
		HopNextKey   = { fg = p.fg.red, bold = true },
		HopNextKey1  = { fg = p.fg.cyan, bold = true },
		HopNextKey2  = { fg = util.darken(p.fg.blue, 0.7) },
		HopUnmatched = { fg = p.fg.gray },
	},

	diffview = {
		DiffviewFilePanelTitle      = { fg = p.fg.blue, bold = true },
		DiffviewFilePanelCounter    = { fg = p.fg.purple, bold = true },
		DiffviewFilePanelFileName   = { fg = p.fg.base },
		DiffviewNormal              = groups.common.Normal,
		DiffviewCursorLine          = groups.common.CursorLine,
		DiffviewVertSplit           = groups.common.VertSplit,
		DiffviewSignColumn          = groups.common.SignColumn,
		DiffviewStatusLine          = groups.common.StatusLine,
		DiffviewStatusLineNC        = groups.common.StatusLineNC,
		DiffviewEndOfBuffer         = groups.common.EndOfBuffer,
		DiffviewFilePanelRootPath   = { fg = p.fg.gray },
		DiffviewFilePanelPath       = { fg = p.fg.gray },
		DiffviewFilePanelInsertions = { fg = p.fg.green },
		DiffviewFilePanelDeletions  = { fg = p.fg.red },
		DiffviewStatusAdded         = { fg = p.fg.green },
		DiffviewStatusUntracked     = { fg = p.fg.blue },
		DiffviewStatusModified      = { fg = p.fg.blue },
		DiffviewStatusRenamed       = { fg = p.fg.blue },
		DiffviewStatusCopied        = { fg = p.fg.blue },
		DiffviewStatusTypeChange    = { fg = p.fg.blue },
		DiffviewStatusUnmerged      = { fg = p.fg.blue },
		DiffviewStatusUnknown       = { fg = p.fg.red },
		DiffviewStatusDeleted       = { fg = p.fg.red },
		DiffviewStatusBroken        = { fg = p.fg.red },
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
		NeoTreeNormal             = { fg = p.fg.base, bg = opts.transparent and p.none or p.bg.dark },
		NeoTreeNormalNC           = { fg = p.fg.base, bg = opts.transparent and p.none or p.bg.dark },
		NeoTreeVertSplit          = { fg = p.bg.base[2], bg = opts.transparent and p.none or p.bg.base[2] },
		NeoTreeWinSeparator       = { fg = p.bg.base[2], bg = opts.transparent and p.none or p.bg.base[2] },
		NeoTreeEndOfBuffer        = { fg = opts.ending_tildes and p.bg.base[3] or p.bg.dark, bg = opts.transparent and p.none or p.bg.dark },
		NeoTreeRootName           = { fg = p.fg.orange, bold = true },
		NeoTreeGitAdded           = { fg = p.fg.green },
		NeoTreeGitDeleted         = { fg = p.fg.red },
		NeoTreeGitModified        = { fg = p.fg.yellow },
		NeoTreeGitConflict        = { fg = p.fg.red, bold = true, italic = true },
		NeoTreeGitUntracked       = { fg = p.fg.red, italic = true },
		NeoTreeIndentMarker       = { fg = p.fg.gray },
		NeoTreeSymbolicLinkTarget = { fg = p.fg.purple },
	},

	neotest = {
		NeotestAdapterName  = { fg = p.fg.purple, bold = true },
		NeotestDir          = { fg = p.fg.cyan },
		NeotestExpandMarker = { fg = p.fg.gray },
		NeotestFailed       = { fg = p.fg.red },
		NeotestFile         = { fg = p.fg.cyan },
		NeotestFocused      = { bold = true, italic = true },
		NeotestIndent       = { fg = p.fg.gray },
		NeotestMarked       = { fg = p.fg.orange, bold = true },
		NeotestNamespace    = { fg = p.fg.blue },
		NeotestPassed       = { fg = p.fg.green },
		NeotestRunning      = { fg = p.fg.yellow },
		NeotestWinSelect    = { fg = p.fg.cyan, bold = true },
		NeotestSkipped      = { fg = p.fg.gray },
		NeotestTarget       = { fg = p.fg.purple },
		NeotestTest         = { fg = p.fg.base },
		NeotestUnknown      = { fg = p.fg.gray },
	},

	nvim_tree = {
		NvimTreeNormal       = { fg = p.fg.base, bg = opts.transparent and p.none or p.bg.dark },
		NvimTreeVertSplit    = { fg = p.bg.dark, bg = opts.transparent and p.none or p.bg.dark },
		NvimTreeEndOfBuffer  = { fg = opts.ending_tildes and p.bg.base[3] or p.bg.dark, bg = opts.transparent and p.none or p.bg.dark },
		NvimTreeRootFolder   = { fg = p.fg.orange, bold = true },
		NvimTreeGitDirty     = { fg = p.fg.yellow },
		NvimTreeGitNew       = { fg = p.fg.green },
		NvimTreeGitDeleted   = { fg = p.fg.red },
		NvimTreeSpecialFile  = { fg = p.fg.yellow, underline = true },
		NvimTreeIndentMarker = { fg = p.fg.base },
		NvimTreeImageFile    = { fg = p.fg.violet },
		NvimTreeSymlink      = { fg = p.fg.purple },
		NvimTreeFolderName   = { fg = p.fg.blue },
	},
	telescope = {
		TelescopeBorder         = { fg = p.fg.red },
		TelescopePromptBorder   = { fg = p.fg.cyan },
		TelescopeResultsBorder  = { fg = p.fg.cyan },
		TelescopePreviewBorder  = { fg = p.fg.cyan },
		TelescopeMatching       = { fg = p.fg.orange, bold = true },
		TelescopePromptPrefix   = { fg = p.fg.green },
		TelescopeSelection      = { bg = p.bg.base[3] },
		TelescopeSelectionCaret = { fg = p.fg.yellow },
	},

	dashboard = {
		DashboardShortCut = { fg = p.fg.blue },
		DashboardHeader   = { fg = p.fg.yellow },
		DashboardCenter   = { fg = p.fg.cyan },
		DashboardFooter   = { fg = p.fg.red, italic = true },
	},

	outline = {
		FocusedSymbol = { fg = p.fg.purple, bg = p.bg.base[3], bold = true },
		AerialLine    = { fg = p.fg.purple, bg = p.bg.base[3], bold = true },
	},

	navic = {
		NavicText      = { fg = p.fg.base },
		NavicSeparator = { fg = p.fg.gray },
	},

	-- stylua: ignore
	rainbow = {
		RainbowRed    = { fg = p.fg.red },
		RainbowOrange = { fg = p.fg.orange },
		RainbowYellow = { fg = p.fg.yellow },
		RainbowLime   = { fg = p.fg.lime },
		RainbowGreen  = { fg = p.fg.green },
		RainbowTeal   = { fg = p.fg.teal },
		RainbowCyan   = { fg = p.fg.cyan },
		RainbowBlue   = { fg = p.fg.blue },
		RainbowIndigo = { fg = p.fg.indigo },
		RainbowViolet = { fg = p.fg.violet },
		RainbowPurple = { fg = p.purple },
		RainbowPink   = { fg = p.fg.pink },
	},

	ts_rainbow = {
		rainbowcol1 = { fg = p.fg.gray },
		rainbowcol2 = { fg = p.fg.yellow },
		rainbowcol3 = { fg = p.fg.blue },
		rainbowcol4 = { fg = p.fg.orange },
		rainbowcol5 = { fg = p.fg.purple },
		rainbowcol6 = { fg = p.fg.green },
		rainbowcol7 = { fg = p.fg.red },
	},

	ts_rainbow2 = {
		TSRainbowRed    = { fg = p.fg.red },
		TSRainbowYellow = { fg = p.fg.yellow },
		TSRainbowBlue   = { fg = p.fg.blue },
		TSRainbowOrange = { fg = p.fg.orange },
		TSRainbowGreen  = { fg = p.fg.green },
		TSRainbowViolet = { fg = p.fg.purple },
		TSRainbowCyan   = { fg = p.fg.cyan },
	},

	rainbow_delimiters = {
		RainbowDelimiterRed    = { fg = p.fg.red },
		RainbowDelimiterYellow = { fg = p.fg.yellow },
		RainbowDelimiterBlue   = { fg = p.fg.blue },
		RainbowDelimiterOrange = { fg = p.fg.orange },
		RainbowDelimiterGreen  = { fg = p.fg.green },
		RainbowDelimiterViolet = { fg = p.fg.purple },
		RainbowDelimiterCyan   = { fg = p.fg.cyan },
	},

	indent_blankline = {
		IndentBlanklineIndent1 = { fg = p.fg.blue },
		IndentBlanklineIndent2 = { fg = p.fg.green },
		IndentBlanklineIndent3 = { fg = p.fg.cyan },
		IndentBlanklineIndent4 = { fg = p.fg.gray },
		IndentBlanklineIndent5 = { fg = p.fg.purple },
		IndentBlanklineIndent6 = { fg = p.fg.red },
		IndentBlanklineChar             = { fg = p.bg.base[2], nocombine = true },
		IndentBlanklineContextChar      = { fg = p.fg.gray, nocombine = true },
		IndentBlanklineContextStart     = { sp = p.fg.gray, underline = true },
		IndentBlanklineContextSpaceChar = { nocombine = true },

		-- Ibl v3
		IblIndent = { fg = p.bg.base[2], nocombine = true },
		IblWhitespace = { fg = p.fg.gray, nocombine = true },
		IblScope = { fg = p.fg.gray, nocombine = true },
	},

	mini = {
		MiniCompletionActiveParameter = { underline = true },

		MiniCursorword = { underline = true },
		MiniCursorwordCurrent = { underline = true },

		MiniIndentscopeSymbol = { fg = p.fg.gray },
		MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible

		MiniJump = { fg = p.fg.purple, underline = true, sp = p.fg.purple },

		MiniJump2dSpot = { fg = p.fg.red, bold = true, nocombine = true },

		MiniStarterCurrent    = { nocombine = true },
		MiniStarterFooter     = { fg = p.fg.red, italic = true },
		MiniStarterHeader     = { fg = p.fg.yellow },
		MiniStarterInactive   = { fg = p.fg.gray },
		MiniStarterItem       = { fg = p.fg.base, bg = opts.transparent and p.none or p.bg.base[1] },
		MiniStarterItemBullet = { fg = p.fg.gray },
		MiniStarterItemPrefix = { fg = p.fg.yellow },
		MiniStarterSection    = { fg = p.fg.gray },
		MiniStarterQuery      = { fg = p.fg.cyan },

		MiniStatuslineDevinfo     = { fg = p.fg.base, bg = p.bg.base[3] },
		MiniStatuslineFileinfo    = { fg = p.fg.base, bg = p.bg.base[3] },
		MiniStatuslineFilename    = { fg = p.fg.gray, bg = p.bg.base[2] },
		MiniStatuslineInactive    = { fg = p.fg.gray, bg = p.bg.base[1] },
		MiniStatuslineModeCommand = { fg = p.bg.base[1], bg = p.fg.yellow, bold = true },
		MiniStatuslineModeInsert  = { fg = p.bg.base[1], bg = p.fg.blue, bold = true },
		MiniStatuslineModeNormal  = { fg = p.bg.base[1], bg = p.fg.green, bold = true },
		MiniStatuslineModeOther   = { fg = p.bg.base[1], bg = p.fg.cyan, bold = true },
		MiniStatuslineModeReplace = { fg = p.bg.base[1], bg = p.fg.red, bold = true },
		MiniStatuslineModeVisual  = { fg = p.bg.base[1], bg = p.fg.purple, bold = true },

		MiniSurround = { fg = p.bg.base[1], bg = p.fg.orange },

		MiniTablineCurrent         = { bold = true },
		MiniTablineFill            = { fg = p.fg.gray, bg = p.bg.base[2] },
		MiniTablineHidden          = { fg = p.fg.base, bg = p.bg.base[2] },
		MiniTablineModifiedCurrent = { fg = p.fg.orange, bold = true, italic = true },
		MiniTablineModifiedHidden  = { fg = p.fg.gray, bg = p.bg.base[2], italic = true },
		MiniTablineModifiedVisible = { fg = p.fg.yellow, bg = p.bg.base[1], italic = true },
		MiniTablineTabpagesection  = { fg = p.bg.base[1], bg = p.bg.yellow },
		MiniTablineVisible         = { fg = p.fg.gray, bg = p.bg.base[1] },

		MiniTestEmphasis = { bold = true },
		MiniTestFail     = { fg = p.fg.red, bold = true },
		MiniTestPass     = { fg = p.fg.green, bold = true },

		MiniTrailspace   = { bg = p.fg.red },
	},

}

groups.langs = {

	c = {
		cInclude      = { fg = p.fg.blue },
		cStorageClass = { fg = p.fg.purple },
		cTypedef      = { fg = p.fg.purple },
		cDefine       = { fg = p.fg.cyan },
		cTSInclude    = { fg = p.fg.blue },
		cTSConstant   = { fg = p.fg.cyan },
		cTSConstMacro = { fg = p.fg.purple },
		cTSOperator   = { fg = p.fg.purple },
	},

	cpp = {
		cppStatement    = { fg = p.fg.purple, bold = true },
		cppTSInclude    = { fg = p.fg.blue },
		cppTSConstant   = { fg = p.fg.cyan },
		cppTSConstMacro = { fg = p.fg.purple },
		cppTSOperator   = { fg = p.fg.purple },
	},

	diff = {
		diffFile    = { fg = p.fg.pink },
		diffLine    = { fg = p.fg.purple, bold = true },
		diffOldFile = { fg = p.fg.yellow },
		diffNewFile = { fg = p.fg.cyan },
		diffAdded   = { fg = p.syntax.diff.add.fg,    bg = bg_is_dark and p.none or p.syntax.diff.add.bg },
		diffRemoved = { fg = p.syntax.diff.delete.fg, bg = bg_is_dark and p.none or p.syntax.diff.delete.bg },
	},

	markdown = {
		markdownH1 = { fg = p.fg.red, bold = true },
		markdownH2 = { fg = p.fg.purple, bold = true },
		markdownH3 = { fg = p.fg.orange, bold = true },
		markdownH4 = { fg = p.fg.red, bold = true },
		markdownH5 = { fg = p.fg.purple, bold = true },
		markdownH6 = { fg = p.fg.orange, bold = true },
		markdownBlockquote        = { fg = p.fg.gray },
		markdownBold              = { fg = p.none, bold = true },
		markdownBoldDelimiter     = { fg = p.fg.gray },
		markdownCode              = { fg = p.fg.green },
		markdownCodeBlock         = { fg = p.fg.green },
		markdownCodeDelimiter     = { fg = p.fg.yellow },
		markdownHeadingDelimiter  = { fg = p.fg.gray },
		markdownHeadingRule       = { fg = p.fg.gray },
		markdownId                = { fg = p.fg.yellow },
		markdownIdDeclaration     = { fg = p.fg.red },
		markdownItalic            = { fg = p.none, italic = true },
		markdownItalicDelimiter   = { fg = p.fg.gray, italic = true },
		markdownLinkDelimiter     = { fg = p.fg.gray },
		markdownLinkText          = { fg = p.fg.red },
		markdownLinkTextDelimiter = { fg = p.fg.gray },
		markdownListMarker        = { fg = p.fg.red },
		markdownOrderedListMarker = { fg = p.fg.red },
		markdownRule              = { fg = p.fg.purple },
		markdownUrl               = { fg = p.fg.blue, underline = true },
		markdownUrlDelimiter      = { fg = p.fg.gray },
		markdownUrlTitleDelimiter = { fg = p.fg.green },
	},

	php = {
		phpFunctions      = { fg = p.fg.base },
		phpMethods        = { fg = p.fg.cyan },
		phpStructure      = { fg = p.fg.purple },
		phpOperator       = { fg = p.fg.purple },
		phpMemberSelector = { fg = p.fg.base },
		phpVarSelector    = { fg = p.fg.orange },
		phpIdentifier     = { fg = p.fg.orange },
		phpBoolean        = { fg = p.fg.cyan },
		phpNumber         = { fg = p.fg.orange },
		phpHereDoc        = { fg = p.fg.green },
		phpNowDoc         = { fg = p.fg.green },
		phpSCKeyword      = { fg = p.fg.purple },
		phpFCKeyword      = { fg = p.fg.purple },
		phpRegion         = { fg = p.fg.blue },
	},

	scala = {
		scalaNameDefinition        = { fg = p.fg.base },
		scalaInterpolationBoundary = { fg = p.fg.purple },
		scalaInterpolation         = { fg = p.fg.purple },
		scalaTypeOperator          = { fg = p.fg.red },
		scalaOperator              = { fg = p.fg.red },
		scalaKeywordModifier       = { fg = p.fg.red },
	},

	tex = {
		latexTSInclude         = { fg = p.fg.blue },
		latexTSFuncMacro       = { fg = p.fg.base },
		latexTSEnvironment     = { fg = p.fg.cyan, bold = true },
		latexTSEnvironmentName = { fg = p.fg.yellow },
		texCmdEnv              = { fg = p.fg.cyan },
		texEnvArgName          = { fg = p.fg.yellow },
		latexTSTitle           = { fg = p.fg.green },
		latexTSType            = { fg = p.fg.blue },
		latexTSMath            = { fg = p.fg.orange },
		texMathZoneX           = { fg = p.fg.orange },
		texMathZoneXX          = { fg = p.fg.orange },
		texMathDelimZone       = { fg = p.fg.gray },
		texMathDelim           = { fg = p.fg.purple },
		texMathOper            = { fg = p.fg.red },
		texCmd                 = { fg = p.fg.purple },
		texCmdPart             = { fg = p.fg.blue },
		texCmdPackage          = { fg = p.fg.blue },
		texPgfType             = { fg = p.fg.yellow },
	},

	vim = {
		vimOption       = { fg = p.fg.red },
		vimSetEqual     = { fg = p.fg.yellow },
		vimMap          = { fg = p.fg.purple },
		vimMapModKey    = { fg = p.fg.orange },
		vimNotation     = { fg = p.fg.red },
		vimMapLhs       = { fg = p.fg.base },
		vimMapRhs       = { fg = p.fg.blue },
		vimVar          = { fg = p.fg.base },
		vimCommentTitle = { fg = p.fg.gray },
	},
}

local lsp_kind_icons_color = {
	Default       = p.fg.purple,
	Array         = p.fg.yellow,
	Boolean       = p.fg.orange,
	Class         = p.fg.yellow,
	Color         = p.fg.green,
	Constant      = p.fg.orange,
	Constructor   = p.fg.blue,
	Enum          = p.fg.purple,
	EnumMember    = p.fg.yellow,
	Event         = p.fg.yellow,
	Field         = p.fg.purple,
	File          = p.fg.blue,
	Folder        = p.fg.orange,
	Function      = p.fg.blue,
	Interface     = p.fg.green,
	Key           = p.fg.cyan,
	Keyword       = p.fg.cyan,
	Method        = p.fg.blue,
	Module        = p.fg.orange,
	Namespace     = p.fg.red,
	Null          = p.fg.gray,
	Number        = p.fg.orange,
	Object        = p.fg.red,
	Operator      = p.fg.red,
	Package       = p.fg.yellow,
	Property      = p.fg.cyan,
	Reference     = p.fg.orange,
	Snippet       = p.fg.red,
	String        = p.fg.green,
	Struct        = p.fg.purple,
	Text          = p.fg.gray,
	TypeParameter = p.fg.red,
	Unit          = p.fg.green,
	Value         = p.fg.orange,
	Variable      = p.fg.purple,
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
