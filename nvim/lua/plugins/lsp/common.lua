--------------------------------------------------------------------------------
-- LSP 共通設定 (on_attach, capabilities)
-- Neovim 0.11+ 新 API (vim.lsp.config) 対応
--------------------------------------------------------------------------------
local M = {}

-- 共通 capabilities
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 共通 on_attach (全言語で使用)
M.on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- 定義ジャンプ用の関数（quickfixリストを表示しない）
  local function goto_definition_in_new_tab()
    vim.cmd("tab split")
    -- カスタムハンドラで最初の結果に直接ジャンプ
    vim.lsp.buf.definition({
      on_list = function(options)
        if options.items and #options.items > 0 then
          local item = options.items[1]
          if item.filename then
            vim.cmd("edit " .. vim.fn.fnameescape(item.filename))
            vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
          end
        end
      end,
    })
  end

  -- gd: 定義ジャンプ（新しいタブ、quickfixなし）
  vim.keymap.set("n", "gd", goto_definition_in_new_tab, opts)

  -- gt: 同じ動作
  vim.keymap.set("n", "gt", goto_definition_in_new_tab, opts)

  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references()
  end, { buffer = bufnr, noremap = true, silent = true, desc = "Find References" })

  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
end

-- LSP サーバー設定ヘルパー (vim.lsp.config + vim.lsp.enable)
M.setup = function(name, config)
  config = config or {}
  config.capabilities = config.capabilities or M.capabilities
  config.on_attach = config.on_attach or M.on_attach

  vim.lsp.config[name] = config
  vim.lsp.enable(name)
end

return M
