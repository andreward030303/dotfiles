require("lspsaga").setup({
  symbol_in_winbar = {
    enable = true,   -- ← これでパンくず無効化
  },
  ui = {
    border = "rounded",     -- ポップアップの枠を丸く
    winblend = 10,          -- ちょっと透明っぽく
  },
  hover = {
    max_width = 0.6,        -- 横幅を制限（見やすくなる）
  },
})

