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
    local align = require("mini.align")

    align.setup() -- デフォルト設定も残す

    -- Visual モードで `gg` 押したら "=" で揃える
    vim.keymap.set("x", "gg", function()
      align.operator({ split_pattern = "=", justify_side = "right" })
    end, { noremap = true, silent = true })
  end,
},


})


