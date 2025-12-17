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
  init_options = {
    preferences = {
      -- 未インポートシンボルの補完を有効化
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
      includeCompletionsWithSnippetText = true,
      includeCompletionsWithInsertText = true,
      includeAutomaticOptionalChainCompletions = true,
      includeCompletionsWithClassMemberSnippets = true,
      includeCompletionsWithObjectLiteralMethodSnippets = true,
      -- 自動インポート設定
      importModuleSpecifierPreference = "shortest",
      importModuleSpecifierEnding = "auto",
      allowIncompleteCompletions = true,
      -- パッケージからの自動インポート
      includePackageJsonAutoImports = "auto",
    },
  },
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
        includeCompletionsForModuleExports = true,
        autoImports = true,
        completeFunctionCalls = true,
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
        completeFunctionCalls = true,
      },
    },
  },
  on_attach = function(client, bufnr)
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
