--------------------------------------------------------------------------------
-- PHP (Intelephense)
--------------------------------------------------------------------------------
local common = require("plugins.lsp.common")

common.setup("intelephense", {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },
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
