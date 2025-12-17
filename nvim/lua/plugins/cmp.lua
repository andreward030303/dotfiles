--------------------------------------------------------------------------------
-- 補完 (nvim-cmp + LuaSnip)
--------------------------------------------------------------------------------
return {
  -- nvim-cmp 本体
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- VSCode スニペットを利用
      require("luasnip.loaders.from_vscode").lazy_load()

      -- autopairs との連携
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Enter を押したかどうかを管理するフラグ
      local has_pressed_enter = false
      cmp.event:on("menu_closed", function()
        has_pressed_enter = false
      end)

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          [" "] = cmp.mapping(function(fallback)
            if cmp.visible() and has_pressed_enter then
              -- 自動インポートを適用するために behavior を指定
              cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              has_pressed_enter = true
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Tab で確定（自動インポート付き）
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Shift+Tab でスニペット内を戻る
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Ctrl+Space で補完を手動で開く
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Ctrl+e でキャンセル
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },  -- LSP を最優先（自動インポート付き）
          { name = "luasnip", priority = 500 },   -- スニペットは後
          { name = "buffer", priority = 250 },
          { name = "path", priority = 100 },
        }),
        -- ソート設定 - LSPの補完を優先
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            -- LSPのkindを優先（Function, Variable等）
            function(entry1, entry2)
              local kind1 = entry1:get_kind()
              local kind2 = entry2:get_kind()
              -- Snippet(15)よりFunction(3), Variable(6)等を優先
              if kind1 ~= kind2 then
                if kind1 == 15 then return false end
                if kind2 == 15 then return true end
              end
              return nil
            end,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        -- 補完ウィンドウの見た目
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- 実験的機能: ghost text
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },

  -- autopairs
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
