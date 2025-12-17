--------------------------------------------------------------------------------
-- lazy.nvim bootstrap + プラグイン読み込み
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins/ 配下の全ファイルを自動読み込み
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
