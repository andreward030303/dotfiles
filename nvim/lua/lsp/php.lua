local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mason 設定
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "intelephense" },
  handlers = {
    function(server)
      lspconfig[server].setup({
        capabilities = capabilities,
        settings = {
          intelephense = {
            diagnostics = {
              enable = true, -- intelephense の診断を有効化
            },
          },
        },
      })
    end,
  },
})

-- null-ls (php-cs-fixer)
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.phpcsfixer, -- 保存時フォーマット
  },
})

-- Mason Tool Installer
require("mason-tool-installer").setup({
  ensure_installed = {
    "intelephense",  -- PHP LSP
    "php-cs-fixer",  -- フォーマッタ
  },
  auto_update = true,
  run_on_start = true,
})

local common = require("lsp")
vim.lsp.config["intelephense"] = {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  settings = {
    intelephense = {
      diagnostics = { enable = true },
    },
  },
}

-- そして、このサーバを有効化
vim.lsp.enable({ "intelephense" })
