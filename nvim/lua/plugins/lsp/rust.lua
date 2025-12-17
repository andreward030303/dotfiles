--------------------------------------------------------------------------------
-- Rust (rust-analyzer)
--------------------------------------------------------------------------------
local common = require("plugins.lsp.common")

common.setup("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
})
