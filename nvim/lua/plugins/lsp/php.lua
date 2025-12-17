--------------------------------------------------------------------------------
-- PHP (Intelephense)
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local common = require("plugins.lsp.common")

lspconfig.intelephense.setup({
  capabilities = common.capabilities,
  on_attach = common.on_attach,
  root_dir = util.root_pattern("composer.json", ".git"),
  settings = {
    intelephense = {
      diagnostics = { enable = true },
      format = { enable = false },  -- null-ls に任せる
      files = {
        exclude = {
          "**/.git/**", "**/node_modules/**",
          "**/vendor/**/Tests/**", "**/vendor/**/tests/**",
          "**/storage/**", "**/cache/**",
        },
        maxMemory = 4096,
      },
    },
  },
})
