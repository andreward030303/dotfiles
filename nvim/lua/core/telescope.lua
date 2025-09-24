-- lua/core/telescope.lua
local telescope = require("telescope")

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "vendor/",
      "storage/",
      "node_modules/",
      "target/",
      "bin/",
      "%.git/",
      "%.cache/",
    },
  },
})

local builtin = require("telescope.builtin")

local function open_in_tab_or_current(fn)
  return function()
    -- Netrw のときはタブを増やさない
    if vim.bo.filetype ~= "netrw" then
      vim.cmd("tab split")
    end
    fn()
  end
end

vim.keymap.set("n", "<leader>ff", open_in_tab_or_current(builtin.find_files), { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", open_in_tab_or_current(builtin.live_grep), { desc = "Live Grep" })

