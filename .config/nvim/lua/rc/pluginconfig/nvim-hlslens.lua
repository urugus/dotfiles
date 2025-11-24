local hlslens = require("hlslens")

hlslens.setup({
  calm_down = true,
  nearest_only = true,
})

-- scrollbar.nvim の search handler が動作するよう、hlslens 初期化後にセットアップ
pcall(function()
  require("scrollbar.handlers.search").setup()
end)
