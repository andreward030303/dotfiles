--------------------------------------------------------------------------------
-- tron-ares.nvim
-- Red neon cyber theme inspired by TRON: Ares
-- A deep black background with intense red neon glow and cyan accents
--------------------------------------------------------------------------------

local M = {}

-- Color palette - TRON: Ares inspired
M.colors = {
  -- Backgrounds (deep void black with subtle hints)
  bg           = "#05050a",      -- void black
  bg_dark      = "#030308",      -- darker void
  bg_alt       = "#0a0a12",      -- slightly elevated
  bg_highlight = "#12080a",      -- subtle RED highlight (ARES感強化)
  bg_visual    = "#2a0a10",      -- selection (より赤く)
  bg_popup     = "#0c0810",      -- popup (赤みを追加)

  -- Foregrounds
  fg           = "#e0d8d8",      -- main text (少し暖色寄り)
  fg_dark      = "#b0a8a8",      -- dimmed text
  fg_gutter    = "#483838",      -- line numbers (赤みを追加)

  -- Red spectrum (main theme color) 🔴 強化！
  red_glow     = "#ff1a1a",      -- brightest neon glow
  red_neon     = "#ff2525",      -- より明るいネオン赤
  red_bright   = "#ff4040",      -- 明るい赤 (変数用)
  red          = "#e02020",      -- standard red
  red_dark     = "#a01515",      -- darker red
  red_deep     = "#400808",      -- very dark red (for backgrounds)
  red_blood    = "#c00a0a",      -- blood red

  -- Red-Orange spectrum (変数用�🟠) 
  coral        = "#ff6050",      -- コーラル (変数メイン)
  coral_light  = "#ff8070",      -- ライトコーラル
  salmon       = "#ff7060",      -- サーモン

  -- Orange spectrum 🟠
  orange_glow  = "#ff6600",      -- brightest neon orange
  orange_neon  = "#ff5a2a",      -- bright orange neon
  orange       = "#e85a30",      -- standard orange
  orange_ember = "#ff4500",      -- ember orange
  amber        = "#ffaa00",      -- amber/gold
  amber_dark   = "#cc8800",      -- darker amber

  -- Pink/Magenta spectrum 🩷
  pink_neon    = "#ff2a6a",      -- hot pink neon
  pink         = "#ff4080",      -- より明るいピンク
  magenta      = "#e03070",      -- マゼンタ (赤寄り)
  magenta_dark = "#a02050",      -- dark magenta

  -- Cyan/Blue spectrum (アクセント - 控えめに) 🔵
  cyan_neon    = "#00e8ff",      -- brightest cyan glow
  cyan         = "#40d0e8",      -- standard cyan (少し明るく)
  cyan_dark    = "#2090a0",      -- darker cyan
  blue_neon    = "#0088ff",      -- electric blue
  blue         = "#3070c0",      -- muted blue
  blue_dark    = "#203858",      -- dark blue

  -- Grays (赤みを帯びたグレー)
  gray         = "#585050",      -- medium gray (warm)
  gray_dark    = "#302828",      -- dark gray (warm)
  gray_darker  = "#1a1515",      -- darker gray (warm)
  comment      = "#804848",      -- より赤い暖色コメント

  -- Semantic colors
  success      = "#30c850",      -- green
  warning      = "#ff8020",      -- オレンジ警告
  error        = "#ff2020",      -- bright red
  info         = "#40d0e8",      -- cyan
  hint         = "#908080",      -- warm gray
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
  h(0, "WinSeparator",  { fg = c.red_deep })
  h(0, "Folded",        { fg = c.comment, bg = c.bg_alt })
  h(0, "NonText",       { fg = c.gray_darker })
  h(0, "SpecialKey",    { fg = c.gray_dark })
  h(0, "Whitespace",    { fg = c.gray_darker })
  h(0, "EndOfBuffer",   { fg = c.bg })
  h(0, "Conceal",       { fg = c.gray })

  ----------------------------------------------------------------------------
  -- Syntax Highlighting
  ----------------------------------------------------------------------------
  h(0, "Comment",       { fg = c.comment, italic = true })
  h(0, "String",        { fg = c.salmon })          -- サーモン（赤オレンジ系）
  h(0, "Character",     { fg = c.coral })           -- コーラル
  h(0, "Number",        { fg = c.orange_neon })
  h(0, "Float",         { fg = c.orange_neon })
  h(0, "Boolean",       { fg = c.red_bright, bold = true })  -- 明るい赤

  h(0, "Identifier",    { fg = c.coral })           -- 識別子をコーラル（赤オレンジ）�
  h(0, "Function",      { fg = c.red_neon })

  h(0, "Statement",     { fg = c.red_neon })
  h(0, "Conditional",   { fg = c.red_glow, bold = true })
  h(0, "Repeat",        { fg = c.red_bright, bold = true })  -- ループも赤系に
  h(0, "Label",         { fg = c.coral })
  h(0, "Keyword",       { fg = c.red_glow, bold = true })
  h(0, "Exception",     { fg = c.red_bright, bold = true })  -- 例外も赤系
  h(0, "Operator",      { fg = c.red_neon })

  h(0, "PreProc",       { fg = c.pink })            -- プリプロセッサはピンク
  h(0, "Include",       { fg = c.pink_neon })       -- importはネオンピンク
  h(0, "Define",        { fg = c.pink })
  h(0, "Macro",         { fg = c.magenta })
  h(0, "PreCondit",     { fg = c.orange })

  h(0, "Type",          { fg = c.cyan })
  h(0, "StorageClass",  { fg = c.cyan, bold = true })
  h(0, "Structure",     { fg = c.cyan })
  h(0, "Typedef",       { fg = c.cyan })

  h(0, "Special",       { fg = c.orange_neon })
  h(0, "SpecialChar",   { fg = c.orange_glow })
  h(0, "Tag",           { fg = c.red_neon })
  h(0, "Delimiter",     { fg = c.fg_dark })
  h(0, "SpecialComment",{ fg = c.amber_dark, italic = true })
  h(0, "Debug",         { fg = c.orange_glow })

  h(0, "Underlined",    { fg = c.cyan, underline = true })
  h(0, "Bold",          { bold = true })
  h(0, "Italic",        { italic = true })
  h(0, "Error",         { fg = c.error, bold = true })
  h(0, "Todo",          { fg = c.bg, bg = c.orange_glow, bold = true })  -- TODOをオレンジに

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
  -- Treesitter
  ----------------------------------------------------------------------------
  -- Identifiers
  h(0, "@variable",                   { fg = c.coral })         -- 変数をコーラル（赤オレンジ）�
  h(0, "@variable.builtin",           { fg = c.red_bright })    -- self, this を明るい赤
  h(0, "@variable.parameter",         { fg = c.coral_light })   -- パラメータをライトコーラル
  h(0, "@variable.parameter.builtin", { fg = c.coral_light })
  h(0, "@variable.member",            { fg = c.salmon })        -- メンバーをサーモン

  h(0, "@constant",                   { fg = c.red_glow })      -- 定数はネオン赤
  h(0, "@constant.builtin",           { fg = c.red_glow, bold = true })
  h(0, "@constant.macro",             { fg = c.red_bright })

  h(0, "@module",                     { fg = c.pink })          -- モジュールをピンク（赤系）
  h(0, "@module.builtin",             { fg = c.pink })
  h(0, "@label",                      { fg = c.coral })

  -- Literals
  h(0, "@string",                     { fg = c.salmon })        -- 文字列をサーモン（赤オレンジ）
  h(0, "@string.documentation",       { fg = c.coral })
  h(0, "@string.regex",               { fg = c.pink_neon })     -- 正規表現をネオンピンク
  h(0, "@string.escape",              { fg = c.red_bright })    -- エスケープ文字
  h(0, "@string.special",             { fg = c.coral })
  h(0, "@string.special.symbol",      { fg = c.pink_neon })
  h(0, "@string.special.url",         { fg = c.cyan, underline = true })

  h(0, "@character",                  { fg = c.coral })
  h(0, "@character.special",          { fg = c.red_bright })

  h(0, "@boolean",                    { fg = c.red_glow, bold = true })  -- boolも赤
  h(0, "@number",                     { fg = c.orange_neon })
  h(0, "@number.float",               { fg = c.orange_neon })

  -- Types
  h(0, "@type",                       { fg = c.pink })          -- 型をピンク（赤系）
  h(0, "@type.builtin",               { fg = c.pink, italic = true })
  h(0, "@type.definition",            { fg = c.pink_neon })

  h(0, "@attribute",                  { fg = c.magenta })       -- アトリビュートをマゼンタ
  h(0, "@attribute.builtin",          { fg = c.pink_neon })
  h(0, "@property",                   { fg = c.salmon })        -- プロパティをサーモン�

  -- Functions
  h(0, "@function",                   { fg = c.red_neon })
  h(0, "@function.builtin",           { fg = c.red_glow })
  h(0, "@function.call",              { fg = c.red_neon })
  h(0, "@function.macro",             { fg = c.magenta })       -- マクロをマゼンタ

  h(0, "@function.method",            { fg = c.red_neon })
  h(0, "@function.method.call",       { fg = c.red_neon })

  h(0, "@constructor",                { fg = c.pink_neon })     -- コンストラクタをネオンピンク

  h(0, "@operator",                   { fg = c.red_neon })

  -- Keywords
  h(0, "@keyword",                    { fg = c.red_glow, bold = true })
  h(0, "@keyword.coroutine",          { fg = c.red_bright, bold = true })   -- async/await 赤
  h(0, "@keyword.function",           { fg = c.red_glow, bold = true })
  h(0, "@keyword.operator",           { fg = c.red_neon })
  h(0, "@keyword.import",             { fg = c.pink_neon })     -- import をネオンピンク
  h(0, "@keyword.type",               { fg = c.red_glow })
  h(0, "@keyword.modifier",           { fg = c.red_glow })
  h(0, "@keyword.repeat",             { fg = c.red_bright, bold = true })   -- ループも赤
  h(0, "@keyword.return",             { fg = c.red_glow, bold = true })     -- returnも赤
  h(0, "@keyword.debug",              { fg = c.coral })
  h(0, "@keyword.exception",          { fg = c.red_bright, bold = true })   -- try/catchも赤

  h(0, "@keyword.conditional",        { fg = c.red_glow, bold = true })
  h(0, "@keyword.conditional.ternary",{ fg = c.red_neon })

  h(0, "@keyword.directive",          { fg = c.magenta })
  h(0, "@keyword.directive.define",   { fg = c.pink_neon })

  -- Punctuation
  h(0, "@punctuation.delimiter",      { fg = c.gray })
  h(0, "@punctuation.bracket",        { fg = c.fg_dark })
  h(0, "@punctuation.special",        { fg = c.red })  -- 特殊記号を赤

  -- Comments
  h(0, "@comment",                    { fg = c.comment, italic = true })
  h(0, "@comment.documentation",      { fg = c.comment, italic = true })
  h(0, "@comment.error",              { fg = c.error, bg = c.red_deep })
  h(0, "@comment.warning",            { fg = c.warning })
  h(0, "@comment.todo",               { fg = c.bg, bg = c.red_glow, bold = true })  -- TODOを赤に
  h(0, "@comment.note",               { fg = c.info })

  -- Markup (Markdown, etc.)
  h(0, "@markup.strong",              { bold = true })
  h(0, "@markup.italic",              { italic = true })
  h(0, "@markup.strikethrough",       { strikethrough = true })
  h(0, "@markup.underline",           { underline = true })
  h(0, "@markup.heading",             { fg = c.red_glow, bold = true })
  h(0, "@markup.heading.1",           { fg = c.red_glow, bold = true })
  h(0, "@markup.heading.2",           { fg = c.red_neon, bold = true })     -- h2も赤
  h(0, "@markup.heading.3",           { fg = c.red_bright, bold = true })
  h(0, "@markup.heading.4",           { fg = c.orange_neon, bold = true })  -- h4はオレンジ
  h(0, "@markup.heading.5",           { fg = c.amber, bold = true })
  h(0, "@markup.heading.6",           { fg = c.orange, bold = true })

  h(0, "@markup.quote",               { fg = c.amber_dark, italic = true })  -- 引用をアンバー
  h(0, "@markup.math",                { fg = c.cyan })
  h(0, "@markup.link",                { fg = c.cyan })
  h(0, "@markup.link.label",          { fg = c.orange })
  h(0, "@markup.link.url",            { fg = c.cyan, underline = true })

  h(0, "@markup.raw",                 { fg = c.amber })  -- コードブロックをアンバー
  h(0, "@markup.raw.block",           { fg = c.amber })

  h(0, "@markup.list",                { fg = c.orange })  -- リストをオレンジ
  h(0, "@markup.list.checked",        { fg = c.success })
  h(0, "@markup.list.unchecked",      { fg = c.fg_gutter })

  -- Tags (HTML, XML, JSX)
  h(0, "@tag",                        { fg = c.red_neon })
  h(0, "@tag.builtin",                { fg = c.red_neon })
  h(0, "@tag.attribute",              { fg = c.orange_neon })  -- 属性をネオンオレンジ
  h(0, "@tag.delimiter",              { fg = c.gray })

  ----------------------------------------------------------------------------
  -- LSP Semantic Tokens
  ----------------------------------------------------------------------------
  h(0, "@lsp.type.class",             { fg = c.pink })          -- クラスをピンク（赤系）
  h(0, "@lsp.type.comment",           { fg = c.comment, italic = true })
  h(0, "@lsp.type.decorator",         { fg = c.magenta })       -- デコレータをマゼンタ
  h(0, "@lsp.type.enum",              { fg = c.pink })          -- enumもピンク
  h(0, "@lsp.type.enumMember",        { fg = c.coral })         -- enum値をコーラル
  h(0, "@lsp.type.function",          { fg = c.red_neon })
  h(0, "@lsp.type.interface",         { fg = c.pink })          -- interfaceもピンク
  h(0, "@lsp.type.keyword",           { fg = c.red_glow, bold = true })
  h(0, "@lsp.type.macro",             { fg = c.magenta })       -- マクロをマゼンタ
  h(0, "@lsp.type.method",            { fg = c.red_neon })
  h(0, "@lsp.type.namespace",         { fg = c.pink })          -- namespaceもピンク
  h(0, "@lsp.type.number",            { fg = c.orange_neon })
  h(0, "@lsp.type.operator",          { fg = c.red_neon })
  h(0, "@lsp.type.parameter",         { fg = c.coral_light })   -- パラメータをライトコーラル
  h(0, "@lsp.type.property",          { fg = c.salmon })        -- プロパティをサーモン
  h(0, "@lsp.type.string",            { fg = c.salmon })        -- 文字列をサーモン
  h(0, "@lsp.type.struct",            { fg = c.pink_neon })     -- structをネオンピンク
  h(0, "@lsp.type.type",              { fg = c.pink })          -- 型をピンク
  h(0, "@lsp.type.typeParameter",     { fg = c.pink })
  h(0, "@lsp.type.variable",          { fg = c.coral })         -- 変数をコーラル�

  h(0, "@lsp.mod.deprecated",         { strikethrough = true })
  h(0, "@lsp.mod.readonly",           { fg = c.coral_light, italic = true })
  h(0, "@lsp.mod.defaultLibrary",     { fg = c.red_dark })

  h(0, "@lsp.typemod.function.defaultLibrary", { fg = c.red_glow })
  h(0, "@lsp.typemod.variable.defaultLibrary", { fg = c.coral_light })

  ----------------------------------------------------------------------------
  -- LSP References
  ----------------------------------------------------------------------------
  h(0, "LspReferenceText",            { bg = c.gray_dark })
  h(0, "LspReferenceRead",            { bg = c.gray_dark })
  h(0, "LspReferenceWrite",           { bg = c.gray_dark, underline = true })
  h(0, "LspSignatureActiveParameter", { fg = c.red_glow, bold = true, underline = true })
  h(0, "LspCodeLens",                 { fg = c.comment })
  h(0, "LspCodeLensSeparator",        { fg = c.gray_dark })
  h(0, "LspInlayHint",                { fg = c.red_dark, bg = c.bg_alt, italic = true })

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

  -- nvim-cmp
  h(0, "CmpItemAbbr",                 { fg = c.fg })
  h(0, "CmpItemAbbrDeprecated",       { fg = c.fg_gutter, strikethrough = true })
  h(0, "CmpItemAbbrMatch",            { fg = c.red_glow, bold = true })
  h(0, "CmpItemAbbrMatchFuzzy",       { fg = c.red_neon, bold = true })
  h(0, "CmpItemMenu",                 { fg = c.fg_dark })

  h(0, "CmpItemKindDefault",          { fg = c.fg_dark })
  h(0, "CmpItemKindText",             { fg = c.fg })
  h(0, "CmpItemKindMethod",           { fg = c.red_neon })
  h(0, "CmpItemKindFunction",         { fg = c.red_neon })
  h(0, "CmpItemKindConstructor",      { fg = c.pink_neon })     -- コンストラクタをピンク
  h(0, "CmpItemKindField",            { fg = c.coral })         -- フィールドをコーラル
  h(0, "CmpItemKindVariable",         { fg = c.coral })         -- 変数をコーラル
  h(0, "CmpItemKindClass",            { fg = c.pink })          -- クラスをピンク
  h(0, "CmpItemKindInterface",        { fg = c.pink })
  h(0, "CmpItemKindModule",           { fg = c.pink })
  h(0, "CmpItemKindProperty",         { fg = c.salmon })        -- プロパティをサーモン
  h(0, "CmpItemKindUnit",             { fg = c.orange_neon })
  h(0, "CmpItemKindValue",            { fg = c.coral })
  h(0, "CmpItemKindEnum",             { fg = c.pink })
  h(0, "CmpItemKindKeyword",          { fg = c.red_glow })
  h(0, "CmpItemKindSnippet",          { fg = c.magenta })       -- スニペットをマゼンタ
  h(0, "CmpItemKindColor",            { fg = c.coral })
  h(0, "CmpItemKindFile",             { fg = c.fg })
  h(0, "CmpItemKindReference",        { fg = c.pink })
  h(0, "CmpItemKindFolder",           { fg = c.coral })
  h(0, "CmpItemKindEnumMember",       { fg = c.coral })
  h(0, "CmpItemKindConstant",         { fg = c.red_glow })      -- 定数を赤
  h(0, "CmpItemKindStruct",           { fg = c.pink_neon })
  h(0, "CmpItemKindEvent",            { fg = c.magenta })
  h(0, "CmpItemKindOperator",         { fg = c.red })
  h(0, "CmpItemKindTypeParameter",    { fg = c.cyan })
  h(0, "CmpItemKindCopilot",          { fg = c.cyan_neon })

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
  h(0, "LeapLabelPrimary",            { fg = c.bg, bg = c.orange_glow, bold = true })  -- プライマリをオレンジ
  h(0, "LeapLabelSecondary",          { fg = c.bg, bg = c.red_glow, bold = true })
  h(0, "LeapBackdrop",                { fg = c.comment })
end

-- Lualine theme export
M.lualine = {
  normal = {
    a = { fg = M.colors.bg, bg = M.colors.red_glow, gui = "bold" },  -- ネオン赤
    b = { fg = M.colors.fg, bg = M.colors.gray_dark },
    c = { fg = M.colors.fg_dark, bg = M.colors.bg_alt },
  },
  insert = {
    a = { fg = M.colors.bg, bg = M.colors.coral, gui = "bold" },     -- コーラル
  },
  visual = {
    a = { fg = M.colors.bg, bg = M.colors.pink_neon, gui = "bold" }, -- ネオンピンク
  },
  replace = {
    a = { fg = M.colors.bg, bg = M.colors.red_bright, gui = "bold" }, -- 明るい赤
  },
  command = {
    a = { fg = M.colors.bg, bg = M.colors.magenta, gui = "bold" },   -- マゼンタ
  },
  inactive = {
    a = { fg = M.colors.fg_gutter, bg = M.colors.bg_dark },
    b = { fg = M.colors.fg_gutter, bg = M.colors.bg_dark },
    c = { fg = M.colors.fg_gutter, bg = M.colors.bg_dark },
  },
}

return M
