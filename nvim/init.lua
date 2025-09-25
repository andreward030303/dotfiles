-- require("user.core.options")
-- require("user.core.keymaps")
-- require("user.core.autocmds")
-- require("plugins")    -- lazy.nvim のセットアップ

require("core.keymaps")
require("core.options")
require("core.diagnostics")
require("plugins")

require("core.cmp")   -- 補完の設定を読み込む

require("core.telescope")

-- require("lsp")
-- -- PHP 設定
require("lsp.php")

require("core.lspsaga")

require("core.colorscheme")
