vim.diagnostic.config({
  virtual_text = { prefix = "▲" }, -- 行内に「▲」付きで表示
  signs = true,                    -- 行番号左にアイコン
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
