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
-- Get capabilities from cmp_nvim_lsp
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

lspconfig.hls.setup({
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  capabilities = capabilities,
  settings = {
    haskell = {
      formattingProvider = "ormolu"
    }
  }
})
