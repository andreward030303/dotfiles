-- Leader キー
vim.g.mapleader = " "

local map = vim.keymap.set

-- ファイル操作/タブ操作
map("n", "<leader>e", ":Ex<CR>", { desc = "Explore (netrw)" })
map("n", "t", ":tab split<CR>", { desc = "New tab" })
map("n", "f", ":tabnext<CR>", { desc = "Next tab" })
map("n", ";", ":tabprevious<CR>", { desc = "Prev tab" })
map("n", "qq", ":q<CR>", { desc = "Quit" })

-- 移動・検索
map("n", "co", "<C-o>", { desc = "Jump back" })
map("n", "cp", "<C-i>", { desc = "Jump forward" })
map("n", "cn", "*", { desc = "Search word under cursor" })
map("n", "cl", "V", { desc = "Select line" })
