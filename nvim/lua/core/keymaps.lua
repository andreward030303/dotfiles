-- Leader キー
vim.g.mapleader = " "

local map = vim.keymap.set

-- ファイル操作/タブ操作
map("n", "<leader>e", ":Ex<CR>", { desc = "Explore (netrw)" })
-- vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Neo-tree toggle" })
-- vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal left<CR>", { desc = "Open Neo-tree (left sidebar)" })
map("n", "t", ":tab split<CR>", { desc = "New tab" })
map("n", "f", ":tabnext<CR>", { desc = "Next tab" })
map("n", ";", ":tabprevious<CR>", { desc = "Prev tab" })
map("n", "qq", ":q<CR>", { desc = "Quit" })

-- 移動・検索
map("n", "co", "<C-o>", { desc = "Jump back" })
map("n", "cp", "<C-i>", { desc = "Jump forward" })
-- map("n", "cn", "*", { desc = "Search word under cursor" })
vim.keymap.set("n", "cn", "*N", { desc = "Search word under cursor (stay)" })
map("n", "cl", "V", { desc = "" })
map("n", "gi", "I", { desc = "" })
map("n", "ga", "A", { desc = "" })

vim.keymap.set("v", "gy", ":w! /app/copy.txt<CR>", { desc = "" })

-- === netrw 用キーマップ ===
local grp = vim.api.nvim_create_augroup("MyNetrwMaps", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = "netrw",
  callback = function(ev)
    local bufopts = { buffer = ev.buf, silent = true, nowait = true }

    -- ★ これが netrw の「Enter（開く）」相当
    -- <Plug> を使うので remap=true が必須
    vim.keymap.set("n", "l", "<Plug>NetrwLocalBrowseCheck",
      vim.tbl_extend("force", bufopts, { remap = true, desc = "Netrw open (like <CR>)" }))

    -- 親ディレクトリへ
    vim.keymap.set("n", "h", "<Plug>NetrwBrowseUpDir",
      vim.tbl_extend("force", bufopts, { remap = true, desc = "Netrw up dir (like -)" }))

    -- 万一 <CR> が壊れてる場合に備え、バッファ内だけ <CR> を素の <CR> に戻す保険
    vim.keymap.set("n", "<CR>", "<CR>", bufopts)
  end,
})

