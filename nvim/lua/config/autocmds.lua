--------------------------------------------------------------------------------
-- Autocmds (プラグイン無関係)
--------------------------------------------------------------------------------

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

-- カスタム filetype
vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "html",  -- Laravel Blade テンプレート
  },
})

-- Diagnostics 表示設定
vim.diagnostic.config({
  virtual_text = { prefix = "▲" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
