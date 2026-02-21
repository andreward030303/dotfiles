--------------------------------------------------------------------------------
-- Neovim 基本オプション
--------------------------------------------------------------------------------
local opt = vim.opt

-- インデント
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- 表示
opt.number = true
opt.background = "dark"
opt.textwidth = 0
opt.termguicolors = true

-- 検索
opt.hlsearch = false

-- クリップボード
opt.clipboard = "unnamed"

-- ファイル
opt.swapfile = false
opt.fileformats = { "unix", "dos" }

-- その他
opt.mouse = ""
vim.o.updatetime = 500
vim.g.editorconfig = false
