--------------------------------------------------------------------------------
-- LSP 共通設定 (Mason + null-ls + 共通 on_attach)
-- 言語別設定は同ディレクトリの各ファイルを参照
--------------------------------------------------------------------------------

-- 共通 on_attach (全言語で使用)
local M = {}

M.on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  vim.keymap.set("n", "gd", function()
    vim.cmd("tab split")
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references()
  end, { buffer = bufnr, noremap = true, silent = true, desc = "Find References" })

  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
end

M.capabilities = function()
  return require("cmp_nvim_lsp").default_capabilities()
end

--------------------------------------------------------------------------------
-- プラグイン定義
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
          "gopls", "gofumpt", "goimports",          -- Go
          "tailwindcss-language-server",            -- Tailwind
          "lua-language-server",                    -- Lua
        },
        auto_update = true,
        run_on_start = true,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "intelephense", "rust_analyzer", "ts_ls", "eslint",
          "gopls", "tailwindcss", "lua_ls",
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
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports,
        },
      })
    end,
  },

  { "nvim-lua/plenary.nvim", lazy = true },
}
