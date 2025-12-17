--------------------------------------------------------------------------------
-- Rust (rust-analyzer)
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
local common = require("plugins.lsp")

lspconfig.rust_analyzer.setup({
  capabilities = common.capabilities(),
  on_attach = common.on_attach,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
})
