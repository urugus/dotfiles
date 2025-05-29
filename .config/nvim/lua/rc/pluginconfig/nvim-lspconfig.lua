local signs = { Error = "", Warn = "", Hint = "󰛩", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- typescript
local lspconfig = require("lspconfig")
lspconfig.ts_ls.setup({
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
})

-- astro
lspconfig.astro.setup({
  cmd = { "astro-ls", "--studio" },
  filetypes = { "astro" },
  init_options = {}
})


-- ruby
lspconfig.solargraph.setup({
  cmd = { "solargraph", "stdio" },  -- 余分なパラメータを削除
  filetypes = { "ruby" },
  init_options = {
    formatting = true,
    diagnostics = true,
    autoformat = false,  -- 自動フォーマットを無効化して起動を早める
    completion = true
  },
  settings = {
    solargraph = {
      commandPath = vim.fn.exepath("solargraph"),
      useBundler = true,  -- Bundlerを使う設定に
      bundlerPath = vim.fn.exepath("bundle"),
      transport = "stdio",
      logLevel = "info",  -- ログレベルを上げて詳細を確認
      promptDownload = false,  -- プロンプトを表示しない
      diagnostics = true
    }
  }
})

-- terraform
lspconfig.terraformls.setup({
  filetypes = { "terraform", "terraform-vars", "tf" },
  cmd = { "terraform-ls", "serve" }
})
