--------------------------------------------------------------------------------
-- 補完 (nvim-cmp + LuaSnip)
-- Tab = Copilot用（cmpでは使わない）
-- Enter → Space = cmp補完確定
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
          -- Space: Enterを押した後なら確定
          [" "] = cmp.mapping(function(fallback)
            if cmp.visible() and has_pressed_enter then
              cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
              has_pressed_enter = false
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Enter: 補完メニューが開いていたら次の候補を選択
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

          -- Tab は Copilot 用なのでここではマッピングしない（fallback）
          -- Shift+Tab でスニペット内を戻る
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Ctrl+n / Ctrl+p で候補選択
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Ctrl+Space で補完を手動で開く
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Ctrl+e でキャンセル
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000, keyword_length = 1 },  -- LSP 最優先、1文字から補完
          { name = "buffer", priority = 300, keyword_length = 3 },
          { name = "path", priority = 200 },
          { name = "luasnip", priority = 100, keyword_length = 2 },   -- スニペットは最後
        }),
        -- ソート設定 - LSP補完を確実に上に
        sorting = {
          priority_weight = 2,
          comparators = {
            -- ソース優先度を最初に
            function(entry1, entry2)
              local source_priority = {
                nvim_lsp = 4,
                buffer = 2,
                path = 1,
                luasnip = 0,
              }
              local p1 = source_priority[entry1.source.name] or 0
              local p2 = source_priority[entry2.source.name] or 0
              if p1 ~= p2 then
                return p1 > p2
              end
              return nil
            end,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
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
        -- ghost_text は Copilot と競合するので無効
        experimental = {
          ghost_text = false,
        },
      })
    end,
  },

  -- autopairs
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
