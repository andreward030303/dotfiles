--------------------------------------------------------------------------------
-- UI (lualine, lspsaga, gitsigns)
--------------------------------------------------------------------------------
return {
  -- Lualine (ステータスライン)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Lspsaga (LSP UI 強化)
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      symbol_in_winbar = { enable = true },
      ui = { border = "rounded", winblend = 10 },
      hover = { max_width = 0.6 },
    },
  },

  -- Gitsigns (Git 差分表示)
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {},
  },
}
