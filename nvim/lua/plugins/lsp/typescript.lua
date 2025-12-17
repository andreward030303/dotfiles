--------------------------------------------------------------------------------
-- TypeScript / JavaScript / React / Next.js
--------------------------------------------------------------------------------
local common = require("plugins.lsp.common")

-- TypeScript Language Server
common.setup("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "package.json", ".git" },
})

-- ESLint (保存時自動修正)
common.setup("eslint", {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
  },
  root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json" },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
    common.on_attach(client, bufnr)
  end,
})

-- Tailwind CSS
common.setup("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html", "css", "scss", "javascript", "javascriptreact",
    "typescript", "typescriptreact", "vue", "svelte",
  },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "package.json" },
})
