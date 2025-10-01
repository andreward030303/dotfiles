-- PHP / Intelephense LSP 設定 (パフォーマンス最適化版)
-- 定義ジャンプが遅い問題の主因になりがちな「二重初期化」「不要なインデックス範囲」を排除します。

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 共通 on_attach/capabilities を外部にまとめている環境に対応 (存在しなくても壊れないように pcall)
local ok_common, common = pcall(require, "lsp")
if ok_common then
  capabilities = common.capabilities or capabilities
end

-- Mason 基本設定
require("mason").setup()

-- null-ls (php-cs-fixer) - フォーマットは null-ls に委譲し、Intelephense 側の format を無効化
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.phpcsfixer,
  },
})

-- Mason Tool Installer (必要ツールの自動インストール)
require("mason-tool-installer").setup({
  ensure_installed = {
    "intelephense",
    "php-cs-fixer",
  },
  auto_update = true,
  run_on_start = true,
})

-- Intelephense を mason-lspconfig 経由で 1 回だけ初期化
require("mason-lspconfig").setup({
  ensure_installed = { "intelephense" },
  handlers = {
    function(server)
      if server ~= "intelephense" then
        return lspconfig[server].setup({ capabilities = capabilities })
      end

      lspconfig.intelephense.setup({
        cmd = { "intelephense", "--stdio" },
        filetypes = { "php" },
        single_file_support = false, -- 単一ファイル(プロジェクト外)は遅いので切る場合は false
        root_dir = util.root_pattern("composer.json", ".git"),
        capabilities = capabilities,
        on_attach = ok_common and common.on_attach or nil,
        flags = { allow_incremental_sync = true },
        settings = {
          intelephense = {
            diagnostics = { enable = true },
            format = { enable = false }, -- null-ls に任せる
            telemetry = { enabled = false },
            files = {
              -- 解析不要/重いディレクトリを除外 (必要に応じて調整)
              exclude = {
                "**/.git/**",
                "**/node_modules/**",
                "**/vendor/**/{Tests,tests,test}/**",
                "**/storage/**",
                "**/cache/**",
                "**/.idea/**",
              },
              maxMemory = 4096, -- メモリを十分に確保 (環境に合わせて調整)
            },
            -- includePaths を使ってフレームワークのスタブを最小限にできればインデックス短縮
            -- environment = { includePaths = { vim.fn.expand('~/.cache/intelephense/stubs') } },
            -- 使用しない大規模 Stub を減らしたい場合は下記を独自列挙する:
            -- stubs = { "core", "standard", "xml", "curl", "date", "json", "pcre", "spl", "PDO" },
          },
        },
      })
    end,
  },
})

-- Tips:
-- :LspInfo でクライアントが 1 つだけ(Intelephense)になったか確認してください。複数出ていたらまだ二重起動です。
-- 初回はインデックス構築で遅くなりますが 2 回目以降はキャッシュで高速化されます。
-- まだ遅ければ vendor のより細かい exclude を追加、あるいは phpactor 併用検討。
