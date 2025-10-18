-- lua/core/cmp.lua
local cmp = require("cmp")
local luasnip = require("luasnip")

-- VSCode スニペットを利用
require("luasnip.loaders.from_vscode").lazy_load()

-- autopairs との連携
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Enterを押したかどうかを管理するフラグ
local has_pressed_enter = false

-- 補完メニューが閉じられたらフラグをリセット
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
    -- Space の動作
    [" "] = cmp.mapping(function(fallback)
      if cmp.visible() and has_pressed_enter then
        -- 候補が出ていて Enter 押済みなら confirm
        cmp.confirm({ select = true })
      else
        -- 普通のスペース
        fallback()
      end
    end, { "i", "s" }),

    -- Enter の動作
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        has_pressed_enter = true  -- Enter押下を記録
        cmp.select_next_item()    -- 必要ならここを cmp.confirm() に変えてもOK
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    -- 必要に応じて他のキー設定も追加可能
    -- ["<S-Tab>"] = cmp.mapping(...),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

