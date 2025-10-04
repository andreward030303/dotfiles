-- ======================================
-- lazy.nvim bootstrap
-- ======================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ======================================
-- Plugins
-- ======================================
require("lazy").setup({

  -- ========================
  -- Copilot
  -- ========================
  { "github/copilot.vim", event = "InsertEnter" },

  -- ========================
  -- LSP
  -- ========================
  { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },
  { "williamboman/mason.nvim", event = "BufReadPre" },
  { "williamboman/mason-lspconfig.nvim", event = "BufReadPre" },
  { "nvimtools/none-ls.nvim", event = "BufReadPre" },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", event = "BufReadPre" },
  { "nvim-lua/plenary.nvim", lazy = true }, -- dependency

  -- ========================
  -- 補完エンジン
  -- ========================
  { "hrsh7th/nvim-cmp", event = "InsertEnter" },
  { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
  { "hrsh7th/cmp-buffer", event = "InsertEnter" },
  { "hrsh7th/cmp-path", event = "InsertEnter" },
  { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
  { "L3MON4D3/LuaSnip", event = "InsertEnter" },
  { "rafamadriz/friendly-snippets", event = "InsertEnter" },

  -- ========================
  -- 補助系
  -- ========================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvimdev/lspsaga.nvim", event = "LspAttach", config = true },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "tree-sitter/tree-sitter-html" },
    },
    config = function()
      require("core.treesitter") -- 外部に設定分離
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup()
    end,
  },

  -- ========================
  -- UI
  -- ========================
  { "folke/tokyonight.nvim", lazy = true },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
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
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- 保存時に自動フォーマットする場合
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                php = { "php_cs_fixer" }, -- PHP用フォーマッタ
                javascript = { "prettier" },
                typescript = { "prettier" },
                html = { "prettier" },
                lua = { "stylua" },
                -- 他の言語も追加できる
            },
        })

        -- 保存時に自動フォーマット
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end,
  },
   {
     "echasnovski/mini.align",
     version = false,
     config = function()
       require("mini.align").setup() -- デフォルト設定を有効化
     end,
   },

 -- ========================
  -- ▼ 追加：Next.js / React / Tailwind / DX用プラグイン
  -- ========================

  -- JSX タグ自動補完
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- TypeScript 拡張 (import整理, ファイルリネーム等)
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require("typescript").setup({
        server = {
          on_attach = function(client, bufnr)
            local ts = require("typescript")
            vim.keymap.set("n", "<leader>oi", ts.actions.organizeImports, { buffer = bufnr })
            vim.keymap.set("n", "<leader>rf", ts.actions.renameFile, { buffer = bufnr })
          end,
        },
      })
    end,
  },

  -- ESLint / Prettier / Lint 統合 (none-ls)
  {
    "nvimtools/none-ls.nvim",
    event = "BufReadPre",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.code_actions.eslint_d,
        },
      })
    end,
  },

  -- Mason連携で自動インストール
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "prettier", "eslint_d", "stylelint" },
        automatic_installation = true,
      })
    end,
  },

  -- TailwindCSS の色プレビュー & クラス補助
  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "typescriptreact", "javascriptreact", "html" },
    config = function()
      require("tailwind-tools").setup({
        document_color = { enabled = true },
        conceal = true,
      })
    end,
  },

  -- 色プレビュー (styled-components / CSSなど)
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- which-key でショートカットガイド
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").add({
        { "<leader>o", group = "organize" },
        { "<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize imports" },
        { "<leader>rf", "<cmd>TypescriptRenameFile<CR>", desc = "Rename file" },
      })
    end,
  },





})
