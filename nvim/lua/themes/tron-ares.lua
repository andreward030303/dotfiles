--------------------------------------------------------------------------------
-- tron-ares.nvim
-- Custom Theme - 5色ベースのカラースキーム
-- #b81132 #5a2dd6 #c24725 #258dc2 #2dab24
--------------------------------------------------------------------------------

local M = {}

-- Color palette - 5色ベース
M.colors = {
  -- Backgrounds (ダークベース)
  bg           = "#0a0a0c",      -- dark base
  bg_dark      = "#060608",      -- deeper dark
  bg_alt       = "#0e0e12",      -- slightly elevated
  bg_highlight = "#141418",      -- subtle highlight
  bg_visual    = "#1a1a2a",      -- selection (紫系)
  bg_popup     = "#0c0c10",      -- popup

  -- Foregrounds
  fg           = "#d0d4dc",      -- main text
  fg_dark      = "#9098a8",      -- dimmed text
  fg_gutter    = "#404858",      -- line numbers

  -- 🔴 Red spectrum (base: #b81132)
  red_neon     = "#e01840",      -- ネオンレッド（明るめ）
  red_glow     = "#d01838",      -- レッドグロウ
  red_bright   = "#f02050",      -- ブライトレッド
  red          = "#b81132",      -- ★ベースカラー
  red_dark     = "#8a0d26",      -- darker red
  red_deep     = "#2a0810",      -- very dark red

  -- 🩷 Pink/Magenta spectrum (redから派生)
  pink_neon    = "#e83878",      -- ホットピンク
  pink         = "#d84070",      -- ピンク
  magenta      = "#c03068",      -- マゼンタ
  magenta_neon = "#f04090",      -- ネオンマゼンタ

  -- 🟣 Purple spectrum (base: #5a2dd6)
  purple_neon  = "#7040f0",      -- ネオンパープル（明るめ）
  purple       = "#5a2dd6",      -- ★ベースカラー
  purple_light = "#8050f0",      -- ライトパープル
  violet       = "#6a38e0",      -- バイオレット
  violet_neon  = "#9050ff",      -- ネオンバイオレット

  -- 🔵 Blue spectrum (base: #258dc2)
  cyan_neon    = "#30b8f0",      -- ネオンシアン（明るめ）
  cyan         = "#40a8d8",      -- シアン
  cyan_soft    = "#60c0e8",      -- ソフトシアン
  cyan_dark    = "#1870a0",      -- ダークシアン
  blue_neon    = "#30a0e8",      -- ネオンブルー
  blue         = "#258dc2",      -- ★ベースカラー
  blue_light   = "#48b0e0",      -- ライトブルー
  blue_dark    = "#1a5080",      -- ダークブルー

  -- 🟢 Green spectrum (base: #2dab24)
  green_neon   = "#40d838",      -- ネオングリーン（明るめ）
  green        = "#2dab24",      -- ★ベースカラー
  green_soft   = "#50c048",      -- ソフトグリーン
  teal_neon    = "#30d8a0",      -- ネオンティール
  teal         = "#28b080",      -- ティール

  -- � Orange spectrum (base: #c24725)
  orange_neon  = "#e85830",      -- ネオンオレンジ（明るめ）
  orange       = "#c24725",      -- ★ベースカラー
  orange_glow  = "#d85030",      -- オレンジグロウ
  coral        = "#e06048",      -- コーラル
  amber        = "#d89020",      -- アンバー

  -- � Yellow spectrum (orangeから派生)
  yellow_neon  = "#e8d020",      -- ネオンイエロー
  yellow       = "#d0c030",      -- イエロー
  gold         = "#e0a020",      -- ゴールド

  -- Grays
  gray         = "#505060",      -- medium gray
  gray_dark    = "#303040",      -- dark gray
  gray_darker  = "#1a1a24",      -- darker gray
  comment      = "#606878",      -- コメント

  -- Semantic colors
  success      = "#2dab24",      -- green (ベースカラー)
  warning      = "#c24725",      -- orange (ベースカラー)
  error        = "#b81132",      -- red (ベースカラー)
  info         = "#258dc2",      -- blue (ベースカラー)
  hint         = "#707888",      -- gray
}

local c = M.colors

M.setup = function()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "tron-ares"

  local h = vim.api.nvim_set_hl

  ----------------------------------------------------------------------------
  -- Editor Base
  ----------------------------------------------------------------------------
  h(0, "Normal",        { fg = c.fg, bg = c.bg })
  h(0, "NormalFloat",   { fg = c.fg, bg = c.bg_popup })
  h(0, "NormalNC",      { fg = c.fg_dark, bg = c.bg_dark })
  h(0, "FloatBorder",   { fg = c.red_dark, bg = c.bg_popup })
  h(0, "FloatTitle",    { fg = c.red_neon, bg = c.bg_popup, bold = true })

  h(0, "Cursor",        { fg = c.bg, bg = c.red_neon })
  h(0, "lCursor",       { fg = c.bg, bg = c.red_neon })
  h(0, "CursorIM",      { fg = c.bg, bg = c.red_neon })
  h(0, "TermCursor",    { fg = c.bg, bg = c.red_neon })
  h(0, "TermCursorNC",  { fg = c.bg, bg = c.red_dark })

  h(0, "CursorLine",    { bg = c.bg_highlight })
  h(0, "CursorColumn",  { bg = c.bg_highlight })
  h(0, "ColorColumn",   { bg = c.red_deep })

  h(0, "LineNr",        { fg = c.fg_gutter })
  h(0, "CursorLineNr",  { fg = c.red_glow, bold = true })
  h(0, "LineNrAbove",   { fg = c.fg_gutter })
  h(0, "LineNrBelow",   { fg = c.fg_gutter })
  h(0, "SignColumn",    { fg = c.fg_gutter, bg = c.bg })
  h(0, "FoldColumn",    { fg = c.fg_gutter, bg = c.bg })

  h(0, "VertSplit",     { fg = c.gray_dark })
  h(0, "WinSeparator",  { fg = c.blue_dark })
  h(0, "Folded",        { fg = c.comment, bg = c.bg_alt })
  h(0, "NonText",       { fg = c.gray_darker })
  h(0, "SpecialKey",    { fg = c.gray_dark })
  h(0, "Whitespace",    { fg = c.gray_darker })
  h(0, "EndOfBuffer",   { fg = c.bg })
  h(0, "Conceal",       { fg = c.gray })

  ----------------------------------------------------------------------------
  -- Syntax Highlighting (宇宙サイバーネオン)
  ----------------------------------------------------------------------------
  h(0, "Comment",       { fg = c.comment, italic = true })
  h(0, "String",        { fg = c.teal_neon })       -- ネオンティール（文字列）
  h(0, "Character",     { fg = c.teal })            -- ティール
  h(0, "Number",        { fg = c.purple_neon })     -- ネオンパープル（数値）
  h(0, "Float",         { fg = c.purple_light })
  h(0, "Boolean",       { fg = c.pink_neon, bold = true })

  h(0, "Identifier",    { fg = c.cyan })            -- シアン（変数）
  h(0, "Function",      { fg = c.blue_neon })       -- ネオンブルー（関数）

  h(0, "Statement",     { fg = c.pink_neon })       -- ネオンピンク
  h(0, "Conditional",   { fg = c.pink_neon, bold = true })
  h(0, "Repeat",        { fg = c.magenta, bold = true })
  h(0, "Label",         { fg = c.violet })
  h(0, "Keyword",       { fg = c.pink_neon, bold = true })  -- ネオンピンク（キーワード）
  h(0, "Exception",     { fg = c.red_neon, bold = true })
  h(0, "Operator",      { fg = c.fg_dark })         -- 控えめ

  h(0, "PreProc",       { fg = c.violet })
  h(0, "Include",       { fg = c.violet_neon })     -- ネオンバイオレット（import）
  h(0, "Define",        { fg = c.purple })
  h(0, "Macro",         { fg = c.purple_neon })
  h(0, "PreCondit",     { fg = c.purple_light })

  h(0, "Type",          { fg = c.green_neon })      -- ネオングリーン（型）
  h(0, "StorageClass",  { fg = c.green, bold = true })
  h(0, "Structure",     { fg = c.teal_neon })
  h(0, "Typedef",       { fg = c.green_neon })

  h(0, "Special",       { fg = c.yellow_neon })     -- ネオンイエロー（特殊）
  h(0, "SpecialChar",   { fg = c.yellow })
  h(0, "Tag",           { fg = c.cyan_neon })
  h(0, "Delimiter",     { fg = c.fg_dark })
  h(0, "SpecialComment",{ fg = c.gold, italic = true })
  h(0, "Debug",         { fg = c.orange })

  h(0, "Underlined",    { fg = c.cyan_neon, underline = true })
  h(0, "Bold",          { bold = true })
  h(0, "Italic",        { italic = true })
  h(0, "Error",         { fg = c.error, bold = true })
  h(0, "Todo",          { fg = c.bg, bg = c.yellow_neon, bold = true })

  ----------------------------------------------------------------------------
  -- UI Elements
  ----------------------------------------------------------------------------
  -- Visual mode
  h(0, "Visual",        { bg = c.bg_visual })
  h(0, "VisualNOS",     { bg = c.bg_visual })

  -- Search
  h(0, "Search",        { fg = c.bg, bg = c.red_neon, bold = true })
  h(0, "IncSearch",     { fg = c.bg, bg = c.orange_neon, bold = true })
  h(0, "CurSearch",     { fg = c.bg, bg = c.cyan_neon, bold = true })
  h(0, "Substitute",    { fg = c.bg, bg = c.pink_neon })

  h(0, "MatchParen",    { fg = c.cyan_neon, bg = c.gray_dark, bold = true })

  -- Popup menu
  h(0, "Pmenu",         { fg = c.fg, bg = c.bg_popup })
  h(0, "PmenuSel",      { fg = c.bg, bg = c.red_neon, bold = true })
  h(0, "PmenuSbar",     { bg = c.gray_dark })
  h(0, "PmenuThumb",    { bg = c.red_dark })
  h(0, "PmenuKind",     { fg = c.cyan, bg = c.bg_popup })
  h(0, "PmenuKindSel",  { fg = c.bg, bg = c.red_neon })
  h(0, "PmenuExtra",    { fg = c.fg_dark, bg = c.bg_popup })
  h(0, "PmenuExtraSel", { fg = c.bg, bg = c.red_neon })

  -- Status line
  h(0, "StatusLine",    { fg = c.fg, bg = c.bg_alt })
  h(0, "StatusLineNC",  { fg = c.fg_gutter, bg = c.bg_dark })
  h(0, "WinBar",        { fg = c.fg, bg = c.bg_alt, bold = true })
  h(0, "WinBarNC",      { fg = c.fg_dark, bg = c.bg_dark })

  -- Tab line
  h(0, "TabLine",       { fg = c.fg_dark, bg = c.bg_dark })
  h(0, "TabLineFill",   { bg = c.bg_dark })
  h(0, "TabLineSel",    { fg = c.red_glow, bg = c.bg, bold = true })

  -- Messages
  h(0, "Title",         { fg = c.red_glow, bold = true })
  h(0, "Directory",     { fg = c.cyan })
  h(0, "ModeMsg",       { fg = c.red_neon, bold = true })
  h(0, "MoreMsg",       { fg = c.cyan })
  h(0, "Question",      { fg = c.cyan })
  h(0, "WarningMsg",    { fg = c.warning, bold = true })
  h(0, "ErrorMsg",      { fg = c.error, bold = true })

  -- Spell
  h(0, "SpellBad",      { undercurl = true, sp = c.error })
  h(0, "SpellCap",      { undercurl = true, sp = c.warning })
  h(0, "SpellLocal",    { undercurl = true, sp = c.info })
  h(0, "SpellRare",     { undercurl = true, sp = c.hint })

  -- Diff
  h(0, "DiffAdd",       { bg = "#0a2818" })
  h(0, "DiffDelete",    { bg = "#280a10" })
  h(0, "DiffChange",    { bg = "#18182a" })
  h(0, "DiffText",      { bg = "#301520" })
  h(0, "diffAdded",     { fg = c.success })
  h(0, "diffRemoved",   { fg = c.error })
  h(0, "diffChanged",   { fg = c.info })
  h(0, "diffOldFile",   { fg = c.amber })
  h(0, "diffNewFile",   { fg = c.orange })
  h(0, "diffFile",      { fg = c.cyan })
  h(0, "diffLine",      { fg = c.comment })
  h(0, "diffIndexLine", { fg = c.magenta })
  h(0, "Added",         { fg = c.success })
  h(0, "Removed",       { fg = c.error })
  h(0, "Changed",       { fg = c.info })

  ----------------------------------------------------------------------------
  -- Diagnostics
  ----------------------------------------------------------------------------
  h(0, "DiagnosticError",             { fg = c.error })
  h(0, "DiagnosticWarn",              { fg = c.warning })
  h(0, "DiagnosticInfo",              { fg = c.info })
  h(0, "DiagnosticHint",              { fg = c.hint })
  h(0, "DiagnosticOk",                { fg = c.success })

  h(0, "DiagnosticSignError",         { fg = c.error })
  h(0, "DiagnosticSignWarn",          { fg = c.warning })
  h(0, "DiagnosticSignInfo",          { fg = c.info })
  h(0, "DiagnosticSignHint",          { fg = c.hint })
  h(0, "DiagnosticSignOk",            { fg = c.success })

  h(0, "DiagnosticVirtualTextError",  { fg = c.error, bg = "#200808" })
  h(0, "DiagnosticVirtualTextWarn",   { fg = c.warning, bg = "#1a1408" })
  h(0, "DiagnosticVirtualTextInfo",   { fg = c.info, bg = "#081820" })
  h(0, "DiagnosticVirtualTextHint",   { fg = c.hint, bg = "#101018" })

  h(0, "DiagnosticUnderlineError",    { undercurl = true, sp = c.error })
  h(0, "DiagnosticUnderlineWarn",     { undercurl = true, sp = c.warning })
  h(0, "DiagnosticUnderlineInfo",     { undercurl = true, sp = c.info })
  h(0, "DiagnosticUnderlineHint",     { undercurl = true, sp = c.hint })

  h(0, "DiagnosticFloatingError",     { fg = c.error })
  h(0, "DiagnosticFloatingWarn",      { fg = c.warning })
  h(0, "DiagnosticFloatingInfo",      { fg = c.info })
  h(0, "DiagnosticFloatingHint",      { fg = c.hint })

  ----------------------------------------------------------------------------
  -- Treesitter (宇宙サイバーネオン)
  ----------------------------------------------------------------------------
  -- Identifiers (変数系はシアン)
  h(0, "@variable",                   { fg = c.cyan })          -- シアン（変数）
  h(0, "@variable.builtin",           { fg = c.cyan_neon })     -- ネオンシアン (self, this)
  h(0, "@variable.parameter",         { fg = c.cyan_soft })     -- ソフトシアン（パラメータ）
  h(0, "@variable.parameter.builtin", { fg = c.cyan_soft })
  h(0, "@variable.member",            { fg = c.teal })          -- ティール（メンバー）

  h(0, "@constant",                   { fg = c.gold })          -- ゴールド（定数）
  h(0, "@constant.builtin",           { fg = c.yellow_neon, bold = true })
  h(0, "@constant.macro",             { fg = c.yellow })

  h(0, "@module",                     { fg = c.violet })        -- バイオレット（モジュール）
  h(0, "@module.builtin",             { fg = c.violet_neon })
  h(0, "@label",                      { fg = c.purple_light })

  -- Literals (文字列系はティール)
  h(0, "@string",                     { fg = c.teal_neon })     -- ネオンティール（文字列）
  h(0, "@string.documentation",       { fg = c.teal })
  h(0, "@string.regex",               { fg = c.magenta_neon })  -- ネオンマゼンタ（正規表現）
  h(0, "@string.escape",              { fg = c.yellow_neon })   -- ネオンイエロー（エスケープ）
  h(0, "@string.special",             { fg = c.green })
  h(0, "@string.special.symbol",      { fg = c.purple_neon })
  h(0, "@string.special.url",         { fg = c.blue_neon, underline = true })

  h(0, "@character",                  { fg = c.teal_neon })
  h(0, "@character.special",          { fg = c.yellow_neon })

  h(0, "@boolean",                    { fg = c.pink_neon, bold = true })  -- ネオンピンク
  h(0, "@number",                     { fg = c.purple_neon })   -- ネオンパープル（数値）
  h(0, "@number.float",               { fg = c.purple_light })

  -- Types (型はネオングリーン)
  h(0, "@type",                       { fg = c.green_neon })    -- ネオングリーン（型）
  h(0, "@type.builtin",               { fg = c.green, italic = true })
  h(0, "@type.definition",            { fg = c.teal_neon })

  h(0, "@attribute",                  { fg = c.purple })        -- パープル（アトリビュート）
  h(0, "@attribute.builtin",          { fg = c.purple_neon })
  h(0, "@property",                   { fg = c.teal })          -- ティール（プロパティ）

  -- Functions (ネオンブルー)
  h(0, "@function",                   { fg = c.blue_neon })     -- ネオンブルー（関数）
  h(0, "@function.builtin",           { fg = c.blue_light })
  h(0, "@function.call",              { fg = c.blue_neon })
  h(0, "@function.macro",             { fg = c.purple_neon })

  h(0, "@function.method",            { fg = c.blue_neon })
  h(0, "@function.method.call",       { fg = c.blue_neon })

  h(0, "@constructor",                { fg = c.green })         -- グリーン（コンストラクタ）

  h(0, "@operator",                   { fg = c.fg_dark })       -- 控えめ

  -- Keywords (ネオンピンク/マゼンタ)
  h(0, "@keyword",                    { fg = c.pink_neon, bold = true })
  h(0, "@keyword.coroutine",          { fg = c.magenta, bold = true })   -- async/await
  h(0, "@keyword.function",           { fg = c.pink_neon, bold = true })
  h(0, "@keyword.operator",           { fg = c.pink })
  h(0, "@keyword.import",             { fg = c.violet_neon })   -- ネオンバイオレット（import）
  h(0, "@keyword.type",               { fg = c.pink_neon })
  h(0, "@keyword.modifier",           { fg = c.magenta })
  h(0, "@keyword.repeat",             { fg = c.magenta, bold = true })
  h(0, "@keyword.return",             { fg = c.pink_neon, bold = true })
  h(0, "@keyword.debug",              { fg = c.orange })
  h(0, "@keyword.exception",          { fg = c.red_neon, bold = true })

  h(0, "@keyword.conditional",        { fg = c.pink_neon, bold = true })
  h(0, "@keyword.conditional.ternary",{ fg = c.pink })

  h(0, "@keyword.directive",          { fg = c.purple })
  h(0, "@keyword.directive.define",   { fg = c.purple_neon })

  -- Punctuation
  h(0, "@punctuation.delimiter",      { fg = c.gray })
  h(0, "@punctuation.bracket",        { fg = c.fg_dark })
  h(0, "@punctuation.special",        { fg = c.purple_light })

  -- Comments
  h(0, "@comment",                    { fg = c.comment, italic = true })
  h(0, "@comment.documentation",      { fg = c.comment, italic = true })
  h(0, "@comment.error",              { fg = c.error, bg = c.red_deep })
  h(0, "@comment.warning",            { fg = c.warning })
  h(0, "@comment.todo",               { fg = c.bg, bg = c.yellow_neon, bold = true })
  h(0, "@comment.note",               { fg = c.info })

  -- Markup (Markdown, etc.)
  h(0, "@markup.strong",              { bold = true })
  h(0, "@markup.italic",              { italic = true })
  h(0, "@markup.strikethrough",       { strikethrough = true })
  h(0, "@markup.underline",           { underline = true })
  h(0, "@markup.heading",             { fg = c.cyan_neon, bold = true })
  h(0, "@markup.heading.1",           { fg = c.cyan_neon, bold = true })
  h(0, "@markup.heading.2",           { fg = c.blue_neon, bold = true })
  h(0, "@markup.heading.3",           { fg = c.purple_neon, bold = true })
  h(0, "@markup.heading.4",           { fg = c.pink_neon, bold = true })
  h(0, "@markup.heading.5",           { fg = c.green_neon, bold = true })
  h(0, "@markup.heading.6",           { fg = c.teal_neon, bold = true })

  h(0, "@markup.quote",               { fg = c.violet, italic = true })
  h(0, "@markup.math",                { fg = c.purple_neon })
  h(0, "@markup.link",                { fg = c.blue_neon })
  h(0, "@markup.link.label",          { fg = c.cyan })
  h(0, "@markup.link.url",            { fg = c.blue_neon, underline = true })

  h(0, "@markup.raw",                 { fg = c.teal })
  h(0, "@markup.raw.block",           { fg = c.teal })

  h(0, "@markup.list",                { fg = c.cyan })
  h(0, "@markup.list.checked",        { fg = c.success })
  h(0, "@markup.list.unchecked",      { fg = c.fg_gutter })

  -- Tags (HTML, XML, JSX)
  h(0, "@tag",                        { fg = c.red_neon })
  h(0, "@tag.builtin",                { fg = c.red_neon })
  h(0, "@tag.attribute",              { fg = c.orange_neon })  -- 属性をネオンオレンジ
  h(0, "@tag.delimiter",              { fg = c.gray })

  ----------------------------------------------------------------------------
  -- LSP Semantic Tokens (宇宙サイバーネオン)
  ----------------------------------------------------------------------------
  h(0, "@lsp.type.class",             { fg = c.green_neon })    -- ネオングリーン（クラス）
  h(0, "@lsp.type.comment",           { fg = c.comment, italic = true })
  h(0, "@lsp.type.decorator",         { fg = c.purple })
  h(0, "@lsp.type.enum",              { fg = c.green_neon })    -- ネオングリーン
  h(0, "@lsp.type.enumMember",        { fg = c.gold })          -- ゴールド
  h(0, "@lsp.type.function",          { fg = c.blue_neon })     -- ネオンブルー（関数）
  h(0, "@lsp.type.interface",         { fg = c.teal_neon })     -- ネオンティール
  h(0, "@lsp.type.keyword",           { fg = c.pink_neon, bold = true })
  h(0, "@lsp.type.macro",             { fg = c.purple_neon })
  h(0, "@lsp.type.method",            { fg = c.blue_neon })
  h(0, "@lsp.type.namespace",         { fg = c.violet })        -- バイオレット
  h(0, "@lsp.type.number",            { fg = c.purple_neon })   -- ネオンパープル
  h(0, "@lsp.type.operator",          { fg = c.fg_dark })
  h(0, "@lsp.type.parameter",         { fg = c.cyan_soft })     -- ソフトシアン
  h(0, "@lsp.type.property",          { fg = c.teal })          -- ティール
  h(0, "@lsp.type.string",            { fg = c.teal_neon })     -- ネオンティール
  h(0, "@lsp.type.struct",            { fg = c.green })
  h(0, "@lsp.type.type",              { fg = c.green_neon })    -- ネオングリーン
  h(0, "@lsp.type.typeParameter",     { fg = c.green })
  h(0, "@lsp.type.variable",          { fg = c.cyan })          -- シアン（変数）

  h(0, "@lsp.mod.deprecated",         { strikethrough = true })
  h(0, "@lsp.mod.readonly",           { fg = c.cyan_soft, italic = true })
  h(0, "@lsp.mod.defaultLibrary",     { fg = c.blue_light })

  h(0, "@lsp.typemod.function.defaultLibrary", { fg = c.blue_light })
  h(0, "@lsp.typemod.variable.defaultLibrary", { fg = c.cyan_soft })

  ----------------------------------------------------------------------------
  -- LSP References
  ----------------------------------------------------------------------------
  h(0, "LspReferenceText",            { bg = c.gray_dark })
  h(0, "LspReferenceRead",            { bg = c.gray_dark })
  h(0, "LspReferenceWrite",           { bg = c.gray_dark, underline = true })
  h(0, "LspSignatureActiveParameter", { fg = c.cyan_neon, bold = true, underline = true })
  h(0, "LspCodeLens",                 { fg = c.comment })
  h(0, "LspCodeLensSeparator",        { fg = c.gray_dark })
  h(0, "LspInlayHint",                { fg = c.violet, bg = c.bg_alt, italic = true })

  ----------------------------------------------------------------------------
  -- Plugins
  ----------------------------------------------------------------------------

  -- Telescope
  h(0, "TelescopeNormal",             { fg = c.fg, bg = c.bg_popup })
  h(0, "TelescopeBorder",             { fg = c.red_dark, bg = c.bg_popup })
  h(0, "TelescopePromptNormal",       { fg = c.fg, bg = c.bg_highlight })
  h(0, "TelescopePromptBorder",       { fg = c.orange_neon, bg = c.bg_highlight })  -- プロンプトをオレンジ
  h(0, "TelescopePromptTitle",        { fg = c.bg, bg = c.orange_glow, bold = true })  -- タイトルをオレンジ
  h(0, "TelescopePromptPrefix",       { fg = c.orange_glow })
  h(0, "TelescopePromptCounter",      { fg = c.fg_dark })
  h(0, "TelescopeResultsNormal",      { fg = c.fg, bg = c.bg_popup })
  h(0, "TelescopeResultsBorder",      { fg = c.gray_dark, bg = c.bg_popup })
  h(0, "TelescopeResultsTitle",       { fg = c.bg, bg = c.red_neon, bold = true })  -- 赤に
  h(0, "TelescopePreviewNormal",      { fg = c.fg, bg = c.bg_dark })
  h(0, "TelescopePreviewBorder",      { fg = c.red_dark, bg = c.bg_dark })
  h(0, "TelescopePreviewTitle",       { fg = c.bg, bg = c.pink_neon, bold = true })
  h(0, "TelescopeSelection",          { fg = c.fg, bg = c.bg_visual, bold = true })
  h(0, "TelescopeSelectionCaret",     { fg = c.red_glow })
  h(0, "TelescopeMultiIcon",          { fg = c.red_neon })
  h(0, "TelescopeMultiSelection",     { fg = c.coral })
  h(0, "TelescopeMatching",           { fg = c.red_glow, bold = true })

  -- nvim-cmp (Cosmic Cyber Neon)
  h(0, "CmpItemAbbr",                 { fg = c.fg })
  h(0, "CmpItemAbbrDeprecated",       { fg = c.fg_gutter, strikethrough = true })
  h(0, "CmpItemAbbrMatch",            { fg = c.cyan_neon, bold = true })      -- マッチ: シアン
  h(0, "CmpItemAbbrMatchFuzzy",       { fg = c.teal_neon, bold = true })      -- ファジー: ティール
  h(0, "CmpItemMenu",                 { fg = c.fg_dark })

  h(0, "CmpItemKindDefault",          { fg = c.fg_dark })
  h(0, "CmpItemKindText",             { fg = c.fg })
  h(0, "CmpItemKindMethod",           { fg = c.blue_neon })      -- メソッド: ブルー
  h(0, "CmpItemKindFunction",         { fg = c.blue_neon })      -- 関数: ブルー
  h(0, "CmpItemKindConstructor",      { fg = c.violet_neon })    -- コンストラクタ: バイオレット
  h(0, "CmpItemKindField",            { fg = c.cyan })           -- フィールド: シアン
  h(0, "CmpItemKindVariable",         { fg = c.cyan_neon })      -- 変数: シアン
  h(0, "CmpItemKindClass",            { fg = c.green_neon })     -- クラス: グリーン
  h(0, "CmpItemKindInterface",        { fg = c.green_neon })     -- インターフェース: グリーン
  h(0, "CmpItemKindModule",           { fg = c.violet_neon })    -- モジュール: バイオレット
  h(0, "CmpItemKindProperty",         { fg = c.cyan })           -- プロパティ: シアン
  h(0, "CmpItemKindUnit",             { fg = c.purple_neon })    -- ユニット: パープル
  h(0, "CmpItemKindValue",            { fg = c.purple_neon })    -- 値: パープル
  h(0, "CmpItemKindEnum",             { fg = c.green_neon })     -- enum: グリーン
  h(0, "CmpItemKindKeyword",          { fg = c.pink_neon })      -- キーワード: ピンク
  h(0, "CmpItemKindSnippet",          { fg = c.magenta })        -- スニペット: マゼンタ
  h(0, "CmpItemKindColor",            { fg = c.pink })           -- カラー: ピンク
  h(0, "CmpItemKindFile",             { fg = c.fg })
  h(0, "CmpItemKindReference",        { fg = c.teal_neon })      -- 参照: ティール
  h(0, "CmpItemKindFolder",           { fg = c.blue_neon })      -- フォルダ: ブルー
  h(0, "CmpItemKindEnumMember",       { fg = c.teal_neon })      -- enumメンバー: ティール
  h(0, "CmpItemKindConstant",         { fg = c.yellow_neon })    -- 定数: イエロー
  h(0, "CmpItemKindStruct",           { fg = c.green_neon })     -- struct: グリーン
  h(0, "CmpItemKindEvent",            { fg = c.pink_neon })      -- イベント: ピンク
  h(0, "CmpItemKindOperator",         { fg = c.fg })
  h(0, "CmpItemKindTypeParameter",    { fg = c.teal_neon })      -- 型パラメータ: ティール
  h(0, "CmpItemKindCopilot",          { fg = c.cyan_neon })      -- Copilot: シアン

  -- Gitsigns
  h(0, "GitSignsAdd",                 { fg = c.success })
  h(0, "GitSignsChange",              { fg = c.amber })         -- 変更をアンバーに
  h(0, "GitSignsDelete",              { fg = c.error })
  h(0, "GitSignsAddNr",               { fg = c.success })
  h(0, "GitSignsChangeNr",            { fg = c.amber })
  h(0, "GitSignsDeleteNr",            { fg = c.error })
  h(0, "GitSignsAddLn",               { bg = "#0a2818" })
  h(0, "GitSignsChangeLn",            { bg = "#1a1808" })       -- オレンジ系の背景
  h(0, "GitSignsDeleteLn",            { bg = "#280a10" })
  h(0, "GitSignsCurrentLineBlame",    { fg = c.comment, italic = true })

  -- Indent Blankline
  h(0, "IblIndent",                   { fg = c.gray_darker })
  h(0, "IblScope",                    { fg = c.orange })        -- スコープをオレンジ
  h(0, "IndentBlanklineChar",         { fg = c.gray_darker })
  h(0, "IndentBlanklineContextChar",  { fg = c.orange })

  -- Neo-tree
  h(0, "NeoTreeNormal",               { fg = c.fg, bg = c.bg_dark })
  h(0, "NeoTreeNormalNC",             { fg = c.fg_dark, bg = c.bg_dark })
  h(0, "NeoTreeRootName",             { fg = c.orange_glow, bold = true })  -- ルートをオレンジ
  h(0, "NeoTreeDirectoryName",        { fg = c.cyan })
  h(0, "NeoTreeDirectoryIcon",        { fg = c.amber })         -- フォルダアイコンをアンバー
  h(0, "NeoTreeFileName",             { fg = c.fg })
  h(0, "NeoTreeFileIcon",             { fg = c.fg_dark })
  h(0, "NeoTreeGitAdded",             { fg = c.success })
  h(0, "NeoTreeGitConflict",          { fg = c.error })
  h(0, "NeoTreeGitDeleted",           { fg = c.error })
  h(0, "NeoTreeGitIgnored",           { fg = c.fg_gutter })
  h(0, "NeoTreeGitModified",          { fg = c.amber })         -- 変更をアンバー
  h(0, "NeoTreeGitUnstaged",          { fg = c.orange_neon })   -- unstaged をオレンジ
  h(0, "NeoTreeGitUntracked",         { fg = c.orange })
  h(0, "NeoTreeGitStaged",            { fg = c.success })
  h(0, "NeoTreeIndentMarker",         { fg = c.gray_dark })
  h(0, "NeoTreeCursorLine",           { bg = c.bg_highlight })

  -- nvim-tree
  h(0, "NvimTreeNormal",              { fg = c.fg, bg = c.bg_dark })
  h(0, "NvimTreeNormalNC",            { fg = c.fg_dark, bg = c.bg_dark })
  h(0, "NvimTreeRootFolder",          { fg = c.orange_glow, bold = true })  -- ルートをオレンジ
  h(0, "NvimTreeFolderName",          { fg = c.cyan })
  h(0, "NvimTreeFolderIcon",          { fg = c.cyan_dark })
  h(0, "NvimTreeOpenedFolderName",    { fg = c.cyan, bold = true })
  h(0, "NvimTreeEmptyFolderName",     { fg = c.fg_gutter })
  h(0, "NvimTreeIndentMarker",        { fg = c.gray_dark })
  h(0, "NvimTreeGitDirty",            { fg = c.warning })
  h(0, "NvimTreeGitStaged",           { fg = c.success })
  h(0, "NvimTreeGitMerge",            { fg = c.error })
  h(0, "NvimTreeGitNew",              { fg = c.magenta })
  h(0, "NvimTreeGitDeleted",          { fg = c.error })
  h(0, "NvimTreeSpecialFile",         { fg = c.pink_neon })
  h(0, "NvimTreeCursorLine",          { bg = c.bg_highlight })

  -- Which-key
  h(0, "WhichKey",                    { fg = c.red_neon })
  h(0, "WhichKeyGroup",               { fg = c.cyan })
  h(0, "WhichKeyDesc",                { fg = c.fg })
  h(0, "WhichKeySeperator",           { fg = c.gray })
  h(0, "WhichKeySeparator",           { fg = c.gray })
  h(0, "WhichKeyFloat",               { bg = c.bg_popup })
  h(0, "WhichKeyBorder",              { fg = c.red_dark, bg = c.bg_popup })
  h(0, "WhichKeyValue",               { fg = c.fg_dark })

  -- Lazy.nvim
  h(0, "LazyNormal",                  { fg = c.fg, bg = c.bg_popup })
  h(0, "LazyButton",                  { fg = c.fg, bg = c.gray_dark })
  h(0, "LazyButtonActive",            { fg = c.bg, bg = c.red_neon, bold = true })
  h(0, "LazyH1",                      { fg = c.bg, bg = c.red_neon, bold = true })
  h(0, "LazyH2",                      { fg = c.red_glow, bold = true })
  h(0, "LazySpecial",                 { fg = c.cyan })
  h(0, "LazyProgressDone",            { fg = c.red_glow })
  h(0, "LazyProgressTodo",            { fg = c.gray_dark })
  h(0, "LazyReasonCmd",               { fg = c.red_neon })
  h(0, "LazyReasonEvent",             { fg = c.orange })
  h(0, "LazyReasonFt",                { fg = c.cyan })
  h(0, "LazyReasonKeys",              { fg = c.pink })
  h(0, "LazyReasonPlugin",            { fg = c.magenta })
  h(0, "LazyReasonRuntime",           { fg = c.amber })
  h(0, "LazyReasonSource",            { fg = c.success })
  h(0, "LazyReasonStart",             { fg = c.info })

  -- Mason
  h(0, "MasonNormal",                 { fg = c.fg, bg = c.bg_popup })
  h(0, "MasonHeader",                 { fg = c.bg, bg = c.red_neon, bold = true })
  h(0, "MasonHighlight",              { fg = c.cyan })
  h(0, "MasonHighlightBlock",         { fg = c.bg, bg = c.cyan })
  h(0, "MasonHighlightBlockBold",     { fg = c.bg, bg = c.cyan, bold = true })
  h(0, "MasonMuted",                  { fg = c.fg_gutter })
  h(0, "MasonMutedBlock",             { fg = c.fg, bg = c.gray_dark })

  -- Noice
  h(0, "NoiceCmdline",                { fg = c.fg })
  h(0, "NoiceCmdlineIcon",            { fg = c.red_neon })
  h(0, "NoiceCmdlineIconSearch",      { fg = c.amber })
  h(0, "NoiceCmdlinePopup",           { fg = c.fg, bg = c.bg_popup })
  h(0, "NoiceCmdlinePopupBorder",     { fg = c.red_dark })
  h(0, "NoiceCmdlinePopupBorderSearch", { fg = c.amber })
  h(0, "NoiceConfirm",                { fg = c.fg, bg = c.bg_popup })
  h(0, "NoiceConfirmBorder",          { fg = c.red_neon })
  h(0, "NoiceMini",                   { fg = c.fg, bg = c.bg_alt })
  h(0, "NoicePopup",                  { fg = c.fg, bg = c.bg_popup })
  h(0, "NoicePopupBorder",            { fg = c.red_dark })
  h(0, "NoicePopupmenu",              { fg = c.fg, bg = c.bg_popup })
  h(0, "NoicePopupmenuBorder",        { fg = c.red_dark })
  h(0, "NoicePopupmenuSelected",      { fg = c.bg, bg = c.red_neon })

  -- Notify
  h(0, "NotifyERRORBorder",           { fg = c.error })
  h(0, "NotifyERRORIcon",             { fg = c.error })
  h(0, "NotifyERRORTitle",            { fg = c.error, bold = true })
  h(0, "NotifyERRORBody",             { fg = c.fg })
  h(0, "NotifyWARNBorder",            { fg = c.warning })
  h(0, "NotifyWARNIcon",              { fg = c.warning })
  h(0, "NotifyWARNTitle",             { fg = c.warning, bold = true })
  h(0, "NotifyWARNBody",              { fg = c.fg })
  h(0, "NotifyINFOBorder",            { fg = c.info })
  h(0, "NotifyINFOIcon",              { fg = c.info })
  h(0, "NotifyINFOTitle",             { fg = c.info, bold = true })
  h(0, "NotifyINFOBody",              { fg = c.fg })
  h(0, "NotifyDEBUGBorder",           { fg = c.hint })
  h(0, "NotifyDEBUGIcon",             { fg = c.hint })
  h(0, "NotifyDEBUGTitle",            { fg = c.hint, bold = true })
  h(0, "NotifyDEBUGBody",             { fg = c.fg })
  h(0, "NotifyTRACEBorder",           { fg = c.magenta })
  h(0, "NotifyTRACEIcon",             { fg = c.magenta })
  h(0, "NotifyTRACETitle",            { fg = c.magenta, bold = true })
  h(0, "NotifyTRACEBody",             { fg = c.fg })
  h(0, "NotifyBackground",            { bg = c.bg_popup })

  -- Dashboard / Alpha
  h(0, "DashboardHeader",             { fg = c.red_glow })
  h(0, "DashboardCenter",             { fg = c.cyan })
  h(0, "DashboardFooter",             { fg = c.comment, italic = true })
  h(0, "DashboardShortCut",           { fg = c.pink_neon })
  h(0, "AlphaHeader",                 { fg = c.red_glow })
  h(0, "AlphaButtons",                { fg = c.cyan })
  h(0, "AlphaShortcut",               { fg = c.pink_neon })
  h(0, "AlphaFooter",                 { fg = c.comment, italic = true })

  -- Bufferline
  h(0, "BufferLineFill",              { bg = c.bg_dark })
  h(0, "BufferLineBackground",        { fg = c.fg_gutter, bg = c.bg_dark })
  h(0, "BufferLineBuffer",            { fg = c.fg_gutter, bg = c.bg_dark })
  h(0, "BufferLineBufferVisible",     { fg = c.fg_dark, bg = c.bg_alt })
  h(0, "BufferLineBufferSelected",    { fg = c.fg, bg = c.bg, bold = true })
  h(0, "BufferLineTab",               { fg = c.fg_gutter, bg = c.bg_dark })
  h(0, "BufferLineTabSelected",       { fg = c.red_glow, bg = c.bg, bold = true })
  h(0, "BufferLineTabClose",          { fg = c.error, bg = c.bg_dark })
  h(0, "BufferLineIndicatorSelected", { fg = c.red_glow })
  h(0, "BufferLineIndicatorVisible",  { fg = c.red_dark })
  h(0, "BufferLineSeparator",         { fg = c.bg_dark, bg = c.bg_dark })
  h(0, "BufferLineSeparatorVisible",  { fg = c.bg_dark, bg = c.bg_alt })
  h(0, "BufferLineSeparatorSelected", { fg = c.bg_dark, bg = c.bg })
  h(0, "BufferLineCloseButton",       { fg = c.fg_gutter, bg = c.bg_dark })
  h(0, "BufferLineCloseButtonVisible",{ fg = c.fg_dark, bg = c.bg_alt })
  h(0, "BufferLineCloseButtonSelected",{ fg = c.error, bg = c.bg })
  h(0, "BufferLineModified",          { fg = c.warning })
  h(0, "BufferLineModifiedVisible",   { fg = c.warning })
  h(0, "BufferLineModifiedSelected",  { fg = c.warning })

  -- Lualine (custom theme table)
  h(0, "lualine_a_normal",            { fg = c.bg, bg = c.red_neon, bold = true })
  h(0, "lualine_b_normal",            { fg = c.fg, bg = c.gray_dark })
  h(0, "lualine_c_normal",            { fg = c.fg_dark, bg = c.bg_alt })
  h(0, "lualine_a_insert",            { fg = c.bg, bg = c.cyan, bold = true })
  h(0, "lualine_a_visual",            { fg = c.bg, bg = c.pink_neon, bold = true })
  h(0, "lualine_a_replace",           { fg = c.bg, bg = c.orange_neon, bold = true })
  h(0, "lualine_a_command",           { fg = c.bg, bg = c.amber, bold = true })
  h(0, "lualine_a_inactive",          { fg = c.fg_gutter, bg = c.bg_dark })

  -- Flash
  h(0, "FlashBackdrop",               { fg = c.comment })
  h(0, "FlashLabel",                  { fg = c.bg, bg = c.red_glow, bold = true })
  h(0, "FlashMatch",                  { fg = c.fg, bg = c.bg_visual })
  h(0, "FlashCurrent",                { fg = c.bg, bg = c.cyan_neon })

  -- Mini (mini.nvim plugins)
  h(0, "MiniCursorword",              { bg = c.gray_dark })
  h(0, "MiniCursorwordCurrent",       { bg = c.gray_dark })
  h(0, "MiniIndentscopeSymbol",       { fg = c.red_dark })
  h(0, "MiniJump",                    { fg = c.bg, bg = c.red_glow })
  h(0, "MiniJump2dSpot",              { fg = c.red_glow, bold = true })
  h(0, "MiniStarterCurrent",          { fg = c.fg })
  h(0, "MiniStarterHeader",           { fg = c.red_glow })
  h(0, "MiniStarterFooter",           { fg = c.comment, italic = true })
  h(0, "MiniStarterItem",             { fg = c.fg })
  h(0, "MiniStarterItemBullet",       { fg = c.red_dark })
  h(0, "MiniStarterItemPrefix",       { fg = c.cyan })
  h(0, "MiniStarterSection",          { fg = c.red_neon, bold = true })
  h(0, "MiniStarterQuery",            { fg = c.cyan_neon })
  h(0, "MiniStatuslineDevinfo",       { fg = c.fg, bg = c.gray_dark })
  h(0, "MiniStatuslineFileinfo",      { fg = c.fg, bg = c.gray_dark })
  h(0, "MiniStatuslineFilename",      { fg = c.fg_dark, bg = c.bg_alt })
  h(0, "MiniStatuslineInactive",      { fg = c.fg_gutter, bg = c.bg_dark })
  h(0, "MiniStatuslineModeCommand",   { fg = c.bg, bg = c.amber, bold = true })
  h(0, "MiniStatuslineModeInsert",    { fg = c.bg, bg = c.cyan, bold = true })
  h(0, "MiniStatuslineModeNormal",    { fg = c.bg, bg = c.red_neon, bold = true })
  h(0, "MiniStatuslineModeOther",     { fg = c.bg, bg = c.magenta, bold = true })
  h(0, "MiniStatuslineModeReplace",   { fg = c.bg, bg = c.orange_neon, bold = true })
  h(0, "MiniStatuslineModeVisual",    { fg = c.bg, bg = c.pink_neon, bold = true })
  h(0, "MiniSurround",                { fg = c.bg, bg = c.cyan })
  h(0, "MiniTablineCurrent",          { fg = c.fg, bg = c.bg, bold = true })
  h(0, "MiniTablineFill",             { bg = c.bg_dark })
  h(0, "MiniTablineHidden",           { fg = c.fg_gutter, bg = c.bg_dark })
  h(0, "MiniTablineModifiedCurrent",  { fg = c.warning, bg = c.bg, bold = true })
  h(0, "MiniTablineModifiedHidden",   { fg = c.warning, bg = c.bg_dark })
  h(0, "MiniTablineModifiedVisible",  { fg = c.warning, bg = c.bg_alt })
  h(0, "MiniTablineTabpagesection",   { fg = c.bg, bg = c.red_neon, bold = true })
  h(0, "MiniTablineVisible",          { fg = c.fg_dark, bg = c.bg_alt })
  h(0, "MiniTrailspace",              { bg = c.error })

  -- Trouble
  h(0, "TroubleNormal",               { fg = c.fg, bg = c.bg_popup })
  h(0, "TroubleCount",                { fg = c.pink_neon, bg = c.gray_dark })
  h(0, "TroubleText",                 { fg = c.fg })
  h(0, "TroublePos",                  { fg = c.fg_dark })
  h(0, "TroubleFile",                 { fg = c.cyan })
  h(0, "TroubleCode",                 { fg = c.comment })
  h(0, "TroubleFoldIcon",             { fg = c.red_dark })
  h(0, "TroubleIndent",               { fg = c.gray_dark })
  h(0, "TroubleIndentFoldClosed",     { fg = c.gray })
  h(0, "TroubleIndentFoldOpen",       { fg = c.gray })
  h(0, "TroubleIndentLast",           { fg = c.gray_dark })
  h(0, "TroubleIndentMiddle",         { fg = c.gray_dark })
  h(0, "TroubleIndentTop",            { fg = c.gray_dark })
  h(0, "TroubleIndentWs",             { fg = c.gray_darker })

  -- LSPSaga
  h(0, "SagaNormal",                  { fg = c.fg, bg = c.bg_popup })
  h(0, "SagaBorder",                  { fg = c.red_dark, bg = c.bg_popup })
  h(0, "SagaTitle",                   { fg = c.red_glow, bold = true })
  h(0, "SagaExpand",                  { fg = c.red_dark })
  h(0, "SagaCollapse",                { fg = c.red_dark })
  h(0, "SagaBeacon",                  { bg = c.red_neon })
  h(0, "SagaFinderFname",             { fg = c.fg, bold = true })
  h(0, "SagaCount",                   { fg = c.bg, bg = c.red_neon, bold = true })
  h(0, "SagaVirtLine",                { fg = c.gray_dark })
  h(0, "SagaSep",                     { fg = c.gray_dark })
  h(0, "SagaInCurrent",               { fg = c.red_neon })
  h(0, "ActionPreviewTitle",          { fg = c.red_glow })
  h(0, "CodeActionText",              { fg = c.fg })
  h(0, "CodeActionNumber",            { fg = c.cyan })

  -- Aerial
  h(0, "AerialNormal",                { fg = c.fg, bg = c.bg_popup })
  h(0, "AerialLine",                  { fg = c.fg, bg = c.bg_visual })
  h(0, "AerialLineNC",                { fg = c.fg_dark })
  h(0, "AerialGuide",                 { fg = c.gray_dark })
  h(0, "AerialClass",                 { fg = c.cyan })
  h(0, "AerialClassIcon",             { fg = c.cyan })
  h(0, "AerialFunction",              { fg = c.red_neon })
  h(0, "AerialFunctionIcon",          { fg = c.red_neon })
  h(0, "AerialMethod",                { fg = c.red_neon })
  h(0, "AerialMethodIcon",            { fg = c.red_neon })

  -- Navic (breadcrumbs)
  h(0, "NavicIconsFile",              { fg = c.fg })
  h(0, "NavicIconsModule",            { fg = c.cyan })
  h(0, "NavicIconsNamespace",         { fg = c.cyan })
  h(0, "NavicIconsPackage",           { fg = c.cyan })
  h(0, "NavicIconsClass",             { fg = c.cyan })
  h(0, "NavicIconsMethod",            { fg = c.red_neon })
  h(0, "NavicIconsProperty",          { fg = c.orange })
  h(0, "NavicIconsField",             { fg = c.orange })
  h(0, "NavicIconsConstructor",       { fg = c.cyan })
  h(0, "NavicIconsEnum",              { fg = c.cyan })
  h(0, "NavicIconsInterface",         { fg = c.cyan })
  h(0, "NavicIconsFunction",          { fg = c.red_neon })
  h(0, "NavicIconsVariable",          { fg = c.fg })
  h(0, "NavicIconsConstant",          { fg = c.orange_neon })
  h(0, "NavicIconsString",            { fg = c.pink })
  h(0, "NavicIconsNumber",            { fg = c.orange_neon })
  h(0, "NavicIconsBoolean",           { fg = c.orange })
  h(0, "NavicIconsArray",             { fg = c.cyan })
  h(0, "NavicIconsObject",            { fg = c.cyan })
  h(0, "NavicIconsKey",               { fg = c.red_glow })
  h(0, "NavicIconsNull",              { fg = c.orange_neon })
  h(0, "NavicIconsEnumMember",        { fg = c.orange })
  h(0, "NavicIconsStruct",            { fg = c.cyan })
  h(0, "NavicIconsEvent",             { fg = c.magenta })
  h(0, "NavicIconsOperator",          { fg = c.red })
  h(0, "NavicIconsTypeParameter",     { fg = c.cyan })
  h(0, "NavicText",                   { fg = c.fg })
  h(0, "NavicSeparator",              { fg = c.orange })  -- セパレータをオレンジ

  -- Hop
  h(0, "HopNextKey",                  { fg = c.orange_glow, bold = true })  -- ホップをオレンジ
  h(0, "HopNextKey1",                 { fg = c.red_glow, bold = true })
  h(0, "HopNextKey2",                 { fg = c.amber })
  h(0, "HopUnmatched",                { fg = c.comment })

  -- Leap
  h(0, "LeapMatch",                   { fg = c.fg, bg = c.bg_visual })
  h(0, "LeapLabelPrimary",            { fg = c.bg, bg = c.cyan_neon, bold = true })   -- ネオンシアン
  h(0, "LeapLabelSecondary",          { fg = c.bg, bg = c.purple_neon, bold = true }) -- ネオンパープル
  h(0, "LeapBackdrop",                { fg = c.comment })
end

-- Lualine theme export (宇宙サイバーネオン)
M.lualine = {
  normal = {
    a = { fg = M.colors.bg, bg = M.colors.cyan_neon, gui = "bold" },    -- ネオンシアン
    b = { fg = M.colors.fg, bg = M.colors.gray_dark },
    c = { fg = M.colors.fg_dark, bg = M.colors.bg_alt },
  },
  insert = {
    a = { fg = M.colors.bg, bg = M.colors.green_neon, gui = "bold" },   -- ネオングリーン
  },
  visual = {
    a = { fg = M.colors.bg, bg = M.colors.purple_neon, gui = "bold" },  -- ネオンパープル
  },
  replace = {
    a = { fg = M.colors.bg, bg = M.colors.pink_neon, gui = "bold" },    -- ネオンピンク
  },
  command = {
    a = { fg = M.colors.bg, bg = M.colors.yellow_neon, gui = "bold" },  -- ネオンイエロー
  },
  inactive = {
    a = { fg = M.colors.fg_gutter, bg = M.colors.bg_dark },
    b = { fg = M.colors.fg_gutter, bg = M.colors.bg_dark },
    c = { fg = M.colors.fg_gutter, bg = M.colors.bg_dark },
  },
}

return M
