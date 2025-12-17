--------------------------------------------------------------------------------
-- キーマップ (プラグイン無関係)
--------------------------------------------------------------------------------
vim.g.mapleader = " "

local map = vim.keymap.set

--------------------------------------------------------------------------------
-- ファイル操作 / タブ操作
--------------------------------------------------------------------------------
map("n", "<leader>e", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("Explore")
  local filename = vim.fn.fnamemodify(file, ":t")
  vim.fn.search("\\V" .. filename, "cw")
end, { desc = "Explore (netrw) and jump to current file" })

map("n", "t", ":tab split<CR>", { desc = "New tab" })
map("n", "f", ":tabnext<CR>", { desc = "Next tab" })
map("n", ";", ":tabprevious<CR>", { desc = "Prev tab" })
map("n", "qq", ":q<CR>", { desc = "Quit" })

--------------------------------------------------------------------------------
-- 移動・検索・編集
--------------------------------------------------------------------------------
map("n", "co", "<C-o>", { desc = "Jump back" })
map("n", "cp", "<C-i>", { desc = "Jump forward" })
map("n", "cn", "*N", { desc = "Search word under cursor (stay)" })
map("n", "cl", "V", { desc = "Select line" })
map("n", "gi", "I", { desc = "Insert at line start" })
map("n", "go", "A", { desc = "Append at line end" })

map("v", "gy", ":w! /code/copy.txt<CR>", { desc = "Yank to file" })
map("v", "gp", "=", { desc = "Format selection" })

--------------------------------------------------------------------------------
-- netrw 用キーマップ
--------------------------------------------------------------------------------
local grp = vim.api.nvim_create_augroup("MyNetrwMaps", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = "netrw",
  callback = function(ev)
    local bufopts = { buffer = ev.buf, silent = true, nowait = true }

    vim.keymap.set("n", "l", "<Plug>NetrwLocalBrowseCheck",
      vim.tbl_extend("force", bufopts, { remap = true, desc = "Netrw open" }))

    vim.keymap.set("n", "h", "<Plug>NetrwBrowseUpDir",
      vim.tbl_extend("force", bufopts, { remap = true, desc = "Netrw up dir" }))

    vim.keymap.set("n", "<CR>", "<CR>", bufopts)
  end,
})
