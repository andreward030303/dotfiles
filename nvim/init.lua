--------------------------------------------------------------------------------
-- Neovim エントリポイント
--------------------------------------------------------------------------------

-- 1. 基本オプション
require("config.options")

-- 2. キーマップ (プラグイン無関係)
require("config.keymaps")

-- 3. Autocmds (filetype, diagnostics 等)
require("config.autocmds")

-- 4. プラグイン (lazy.nvim)
require("config.lazy")
