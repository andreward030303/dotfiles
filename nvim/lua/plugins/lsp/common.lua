--------------------------------------------------------------------------------
-- LSP 共通設定 (on_attach, capabilities)
--------------------------------------------------------------------------------
local M = {}

-- 共通 capabilities
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 共通 on_attach (全言語で使用)
M.on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  vim.keymap.set("n", "gd", function()
    vim.cmd("tab split")
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references()
  end, { buffer = bufnr, noremap = true, silent = true, desc = "Find References" })

  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
end

return M
