local opt = vim.opt

-- インデント
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- 表示
opt.background = "dark"
opt.textwidth = 0

-- クリップボード
opt.clipboard = "unnamed"

-- ファイル・検索
opt.swapfile = false
opt.hlsearch = false

vim.o.updatetime = 500  -- 0.5秒くらいが VSCode っぽい
