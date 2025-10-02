-- lua/core/telescope.lua
local telescope = require("telescope")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")

-- 大きいファイルのプレビューを抑止（> 200KB）
local function large_file_safe_previewer(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  local ok, stat = pcall(vim.loop.fs_stat, filepath)
  if ok and stat and stat.size and stat.size > 200 * 1024 then
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Preview disabled (file > 200KB)" })
      end
    end)
    return
  end
  return previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

-- fd があれば優先、無ければ rg --files
local find_cmd
if vim.fn.executable("fd") == 1 then
  find_cmd = {
    "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--follow",
    "--exclude", ".git",
    "--exclude", "node_modules",
    "--exclude", "vendor",
    "--exclude", "storage",
    "--exclude", "dist",
    "--exclude", "build",
    "--exclude", ".cache",
    "--exclude", "coverage",
    "--exclude", "tmp",
  }
else
  find_cmd = {
    "rg", "--files", "--hidden", "--follow",
    "--glob", "!.git/*",
    "--glob", "!node_modules/*",
    "--glob", "!vendor/*",
    "--glob", "!storage/*",
    "--glob", "!dist/*",
    "--glob", "!build/*",
    "--glob", "!.cache/*",
    "--glob", "!coverage/*",
    "--glob", "!tmp/*",
  }
end

telescope.setup({
  defaults = {
    buffer_previewer_maker = large_file_safe_previewer,
    -- live_grep 用 rg の標準引数（隠しファイルも対象、重いフォルダは除外）
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--follow",
      "--glob", "!.git/*",
      "--glob", "!node_modules/*",
      "--glob", "!vendor/*",
      "--glob", "!storage/*",
      "--glob", "!dist/*",
      "--glob", "!build/*",
      "--glob", "!.cache/*",
      "--glob", "!coverage/*",
      "--glob", "!tmp/*",
    },
    file_ignore_patterns = {
      "%.git/",
      "node_modules/",
      "vendor/",
      "storage/",
      "dist/",
      "build/",
      "target/",
      "%.cache/",
      "coverage/",
      "tmp/",
    },
    path_display = { "truncate" },
    color_devicons = false,
    preview = { treesitter = false, timeout = 150 },
    sorting_strategy = "ascending",
    layout_config = { prompt_position = "top", horizontal = { preview_width = 0.55 } },
    -- ここでカスタムキーマップ: Enter で下へ移動 / Tab で開く / Shift-Tab でマルチ選択トグル
    mappings = {
      i = {
        ["<CR>"] = actions.move_selection_next,
        ["<Tab>"] = actions.select_default,
        ["<S-Tab>"] = actions.toggle_selection,
      },
      n = {
        ["<CR>"] = actions.move_selection_next,
        ["<Tab>"] = actions.select_default,
        ["<S-Tab>"] = actions.toggle_selection,
      },
    },
  },
  pickers = {
    find_files = { find_command = find_cmd },
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

