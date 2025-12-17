--------------------------------------------------------------------------------
-- TypeScript / JavaScript / React / Next.js
--------------------------------------------------------------------------------
local common = require("plugins.lsp.common")

-- TypeScript Language Server (自動インポート対応)
common.setup("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "package.json", ".git" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      suggest = {
        includeCompletionsForModuleExports = true,  -- 外部モジュールの補完を含める
        autoImports = true,                          -- 自動インポートを有効化
      },
      preferences = {
        importModuleSpecifier = "shortest",          -- 最短パスでインポート
        includePackageJsonAutoImports = "auto",      -- package.json からの自動インポート
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      suggest = {
        includeCompletionsForModuleExports = true,
        autoImports = true,
      },
      preferences = {
        importModuleSpecifier = "shortest",
        includePackageJsonAutoImports = "auto",
      },
    },
    completions = {
      completeFunctionCalls = true,                  -- 関数呼び出しを補完
    },
  },
  on_attach = function(client, bufnr)
    -- 補完確定時に自動インポートを実行するための設定
    common.on_attach(client, bufnr)
  end,
})

-- ESLint (保存時自動修正)
common.setup("eslint", {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
  },
  root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js", "eslint.config.mjs", "package.json" },
  on_attach = function(client, bufnr)
    -- 保存時に ESLint で自動修正
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        -- ESLint の code action を実行
        vim.lsp.buf.code_action({
          context = {
            only = { "source.fixAll.eslint" },
            diagnostics = {},
          },
          apply = true,
        })
      end,
    })
    common.on_attach(client, bufnr)
  end,
})

-- Tailwind CSS
common.setup("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html", "css", "scss", "javascript", "javascriptreact",
    "typescript", "typescriptreact", "vue", "svelte",
  },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "package.json" },
})
