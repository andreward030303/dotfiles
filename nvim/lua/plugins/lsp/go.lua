--------------------------------------------------------------------------------
-- Go (gopls)
--------------------------------------------------------------------------------
local common = require("plugins.lsp.common")

common.setup("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.mod", "go.work", ".git" },
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
