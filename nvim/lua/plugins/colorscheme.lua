--------------------------------------------------------------------------------
-- カラースキーム (バックアップ/代替用)
--------------------------------------------------------------------------------
return {
  -- tokyonight: :colorscheme tokyonight で切り替え可能
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
      })
    end,
  },

  -- catppuccin: :colorscheme catppuccin で切り替え可能
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },
}
