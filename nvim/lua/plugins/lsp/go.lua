--------------------------------------------------------------------------------
-- Go (gopls)
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
local common = require("plugins.lsp.common")

lspconfig.gopls.setup({
  capabilities = common.capabilities,
  on_attach = function(client, bufnr)
    -- 保存時に自動フォーマット
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
    common.on_attach(client, bufnr)
  end,
  settings = {
    gopls = {
      analyses = { unusedparams = true, shadow = true },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
