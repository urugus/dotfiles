-- キーマップ (<C-_>) は rc/keymaps/plugins.lua にある。
-- pre_hook 以外はすべてデフォルト値なので省略する。
require("Comment").setup({
  -- treesitter から filetype に応じた commentstring を得る
  pre_hook = function()
    return require("ts_context_commentstring.internal").calculate_commentstring()
  end,
})
