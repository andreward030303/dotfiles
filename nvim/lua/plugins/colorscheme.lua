--------------------------------------------------------------------------------
-- カラースキーム
--------------------------------------------------------------------------------
return {
  -- 自作テーマ: tron-ares (TRON: Ares インスパイア)
  {
    "tron-ares",
    name = "tron-ares",
    dev = true,  -- ローカルテーマとして扱う
    lazy = false,
    priority = 1000,
    config = function()
      require("themes.tron-ares").setup()
    end,
  },

  -- バックアップ用: tokyonight (切り替え可能)
  {
    "folke/tokyonight.nvim",
    lazy = true,  -- 使う時だけ読み込む
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
      })
    end,
  },
}
