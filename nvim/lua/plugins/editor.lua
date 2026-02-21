--------------------------------------------------------------------------------
-- エディタ補助 (Comment, mini.align, Copilot)
--------------------------------------------------------------------------------
return {
  -- コメントトグル
  { "numToStr/Comment.nvim", event = "BufReadPost", opts = {} },

  -- 整列
  { "echasnovski/mini.align", version = false, opts = {} },

  -- GitHub Copilot
  { "github/copilot.vim", event = "InsertEnter" },
}
