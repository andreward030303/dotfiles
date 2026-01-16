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
        highlight = {
          enable = true,
          -- Bladeファイルでのハイライトエラーを軽減
          additional_vim_regex_highlighting = { "blade" },
        },
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

      -- Bladeファイル保存時にTreesitterパーサーを再同期
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.blade.php",
        callback = function()
          vim.schedule(function()
            if vim.bo.filetype == "blade" then
              vim.cmd("write | edit")
            end
          end)
        end,
        desc = "Refresh Treesitter for Blade files after save",
      })
    end,
  },
}
