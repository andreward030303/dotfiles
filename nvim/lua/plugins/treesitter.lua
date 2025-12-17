--------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "php", "php_only", "blade", "lua", "rust", "go",
          "typescript", "javascript", "json", "yaml",
          "html", "css", "tsx", "dart", "toml",
          "markdown", "markdown_inline", "dockerfile", "gitignore",
        },
        auto_install = true,  -- 開いたファイルのパーサーを自動インストール
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "dn",
            node_incremental = "n",
            node_decremental = "b",
          },
        },
        matchup = { enable = true },
      })
    end,
  },
}
