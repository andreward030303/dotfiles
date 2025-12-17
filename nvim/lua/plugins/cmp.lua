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
              cmp.confirm({ select = true })
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
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- autopairs
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
