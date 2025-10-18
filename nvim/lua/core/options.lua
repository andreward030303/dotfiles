local opt = vim.opt

-- インデント
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
vim.opt.number = true
vim.opt.hlsearch = true

-- 表示
opt.background = "dark"
opt.textwidth = 0

-- クリップボード
opt.clipboard = "unnamed"

-- ファイル・検索
opt.swapfile = false
opt.hlsearch = false

vim.o.updatetime = 500  -- 0.5秒くらいが VSCode っぽい

opt.mouse = ""

vim.opt.termguicolors = true
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- 前回のカーソル位置に戻る
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
