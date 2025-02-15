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
  cmd = { "solargraph", "stdio", "ruby-lsp" },
  filetypes = { "ruby" }
})
