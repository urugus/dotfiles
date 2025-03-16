-- 組み込みの診断表示をオフにする
vim.diagnostic.config({
  virtual_text = false, -- 標準のvirtual textをオフに
  -- 他の診断設定はそのまま維持
  float = {
    source = "always",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- tiny-inline-diagnosticの基本設定
require("tiny-inline-diagnostic").setup({
  signs = {
    left = "",
    right = "",
    diag = "●",
    arrow = "    ",
    up_arrow = "    ",
    vertical = " │",
    vertical_end = " └",
  },
  blend = {
    factor = 0.22,
  },
  transparent_bg = true,
  highlight = {
    error = "DiagnosticVirtualTextError",
    warn = "DiagnosticVirtualTextWarn",
    info = "DiagnosticVirtualTextInfo",
    hint = "DiagnosticVirtualTextHint",
  },
  show_prefix = true, -- エラーの種類（E:, W:など）を表示
  align_right = true, -- 右揃え
  separator = " ", -- 本文との区切り文字
  max_diagnostic_length = 100, -- 診断メッセージの最大長
})
