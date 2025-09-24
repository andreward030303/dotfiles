-- colorscheme があれば読み込む
vim.cmd("syntax on")
vim.opt.background = "dark"

-- lazy.nvim で colorscheme プラグインを入れてるならここで設定
-- require("github-theme").setup({
--   options = {
--     transparent = false,   -- 背景透過 (true で有効化)
--     terminal_colors = true, -- ターミナルの色も同期
--     styles = {
--       comments = "italic",
--       keywords = "bold",
--       functions = "bold",
--       variables = "NONE",
--     },
--   },
-- })

-- カラースキームを有効化
-- vim.cmd.colorscheme("github_dark")
vim.cmd.colorscheme("monokai")
