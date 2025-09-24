-- require("user.core.options")
-- require("user.core.keymaps")
-- require("user.core.autocmds")
-- require("plugins")    -- lazy.nvim のセットアップ

require("core.options")
require("core.keymaps")

-- require("core.colorscheme")

-- diagnostic 設定
require("core.diagnostics")

-- lazy.nvim プラグイン読み込み
require("plugins")

require("core.cmp")   -- 補完の設定を読み込む

require("core.telescope")

-- require("lsp")
-- -- PHP 設定
require("lsp.php")

require("core.lspsaga")

