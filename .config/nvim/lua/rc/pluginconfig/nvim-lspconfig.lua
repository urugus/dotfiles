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
-- Mason-lspconfigでSolargraphが管理されているため、ここでの設定を削除
-- Solargraphの設定はMasonのハンドラーで行われる

-- terraform
lspconfig.terraformls.setup({
  filetypes = { "terraform", "terraform-vars", "tf" },
  cmd = { "terraform-ls", "serve" }
})

-- haskell (managed by ghcup)
lspconfig.hls.setup({
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  settings = {
    haskell = {
      formattingProvider = "ormolu"
    }
  }
})
