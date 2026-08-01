-- キーマップ (mappings) はプラグインのデフォルトをそのまま使う。
-- 以前は 201 行あったが、picker 以外はすべてデフォルト値の再掲だった。
require("octo").setup({
  picker = "snacks", -- デフォルトは telescope
})
