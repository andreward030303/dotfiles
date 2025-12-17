--------------------------------------------------------------------------------
-- Lua (lua_ls - Neovim 設定用)
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
local common = require("plugins.lsp")

lspconfig.lua_ls.setup({
  capabilities = common.capabilities(),
  on_attach = common.on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
})
