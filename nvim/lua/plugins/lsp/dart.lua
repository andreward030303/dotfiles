--------------------------------------------------------------------------------
-- Flutter / Dart (Flutter SDK 付属の dartls を使用)
--------------------------------------------------------------------------------
local common = require("plugins.lsp.common")

common.setup("dartls", {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  root_markers = { "pubspec.yaml", ".git" },
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
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
})
