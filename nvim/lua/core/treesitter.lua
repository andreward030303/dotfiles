-- lua/core/treesitter.lua
require("nvim-treesitter.configs").setup({
  -- インストールする言語
  ensure_installed = {
    "php",
    "lua",
    "rust",
    "go",
    "typescript",
    "javascript",
    "json",
    "yaml",
    "html",
    "css",
  },

  highlight = { enable = true }, -- 構文ハイライト
  indent = { enable = true },    -- インデント補助

  -- 増分選択（コードブロックを拡張して選択できる）
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",        -- カーソル位置から選択開始
      node_incremental = "<CR>",      -- <CR> で選択範囲を広げる
      node_decremental = "<BS>",      -- <BS> で選択範囲を縮める
    },
  },

  -- 括弧やタグの対応付け強化
  matchup = { enable = true },
})

