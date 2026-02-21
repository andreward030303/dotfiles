--------------------------------------------------------------------------------
-- LSP プラグイン定義 (Mason + null-ls)
-- 共通設定: common.lua / 言語別設定: 各言語ファイル
-- Neovim 0.11+ 新 API (vim.lsp.config) 使用
--------------------------------------------------------------------------------
return {
  -- Mason
  { "williamboman/mason.nvim", lazy = true },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true },

  -- lspconfig (共通初期化)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()

      require("mason-tool-installer").setup({
        ensure_installed = {
          "intelephense", "php-cs-fixer",           -- PHP
          "rust-analyzer",                          -- Rust
          "typescript-language-server", "eslint-lsp", "prettier",  -- TS/JS
          -- "gopls", "gofumpt", "goimports",       -- Go (Go 環境がある場合のみ有効化)
          "tailwindcss-language-server",            -- Tailwind
          "lua-language-server",                    -- Lua
        },
        auto_update = true,
        run_on_start = true,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "intelephense", "rust_analyzer", "ts_ls", "eslint",
          -- "gopls",                               -- Go 環境がある場合のみ有効化
          "tailwindcss", "lua_ls",
        },
      })

      -- 言語別設定を読み込み
      require("plugins.lsp.php")
      require("plugins.lsp.rust")
      require("plugins.lsp.typescript")
      require("plugins.lsp.go")
      require("plugins.lsp.dart")
      require("plugins.lsp.lua")
    end,
  },

  -- null-ls (フォーマッタ/リンター)
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.phpcsfixer,
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript", "javascriptreact", "typescript", "typescriptreact",
              "json", "yaml", "markdown", "html", "css", "scss",
            },
          }),
          -- Go (Go 環境がある場合のみ有効化)
          -- null_ls.builtins.formatting.gofumpt,
          -- null_ls.builtins.formatting.goimports,
        },
      })
    end,
  },

  { "nvim-lua/plenary.nvim", lazy = true },
}
