--------------------------------------------------------------------------------
-- TypeScript / JavaScript / React / Next.js
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
local common = require("plugins.lsp.common")

-- TypeScript Language Server
lspconfig.ts_ls.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
  },
})

-- ESLint (保存時自動修正)
lspconfig.eslint.setup({
  capabilities = common.capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
    common.on_attach(client, bufnr)
  end,
})

-- Tailwind CSS
lspconfig.tailwindcss.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
})
