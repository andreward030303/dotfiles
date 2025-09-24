local M = {}

M.on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- 定義ジャンプを新しいタブで開く
  vim.keymap.set("n", "gd", function()
    vim.cmd("tab split")
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references()
  end, { noremap = true, silent = true, desc = "Find References" })

  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.hover()
    end,
  })
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
