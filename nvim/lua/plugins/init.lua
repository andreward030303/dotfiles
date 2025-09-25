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

require("lazy").setup({
    -- ========================
    -- LSP / 開発支援
    -- ========================
    { "github/copilot.vim" }, -- Copilot プラグイン
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "nvimtools/none-ls.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    { "nvim-lua/plenary.nvim" },

    -- ========================
    -- 補完エンジン
    -- ========================
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" }, -- ← Snippet連携も追加すると便利

    -- 補助系
    { "rafamadriz/friendly-snippets" }, -- スニペット集
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
          require("nvim-autopairs").setup({})
      end,
    },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvimdev/lspsaga.nvim", event = "LspAttach", config = true },

    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
          require("core.treesitter")  -- ← 設定を外部ファイルで管理
      end,
    },
    {
      "numToStr/Comment.nvim",
      config = function()
          require("Comment").setup()
      end,
    },
    { "folke/tokyonight.nvim" },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            theme = "auto",      -- colorscheme に合わせて自動
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
  config = function()
    require("gitsigns").setup()
  end,
},
})



