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
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
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
  { "windwp/nvim-autopairs" },      -- 括弧自動補完

  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  { "nvimdev/lspsaga.nvim", event = "LspAttach", config = true },

})
