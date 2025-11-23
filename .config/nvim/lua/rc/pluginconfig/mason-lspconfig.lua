local group_name = "vimrc_lsp_attach"
vim.api.nvim_create_augroup(group_name, { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    require("rc.keymaps.lsp").apply(client, bufnr)
  end,
  group = group_name,
})

-- Get capabilities from cmp_nvim_lsp
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- Setup Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "rust_analyzer", "lua_ls", "terraformls", "pyright", "solargraph" },
})

-- Configure LSP servers with custom settings using vim.lsp.config()

-- lua_ls: Lua Language Server
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      hint = { enable = true },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "tab",
          indent_size = "2",
        },
      },
    },
  },
})

-- solargraph: Ruby Language Server (custom config to prevent infinite reload)
vim.lsp.config("solargraph", {
  capabilities = capabilities,
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  init_options = {
    formatting = false,
    diagnostics = false, -- Disable rubocop diagnostics to avoid errors
    autoformat = false,
    completion = true,
  },
  settings = {
    solargraph = {
      useBundler = false,
      transport = "stdio",
      logLevel = "warn",
      promptDownload = false,
      diagnostics = false, -- Disable rubocop diagnostics
      checkGemVersion = false,
      folding = false,
    },
  },
})

-- hls: Haskell Language Server (managed by ghcup, not Mason)
vim.lsp.config("hls", {
  capabilities = capabilities,
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  settings = {
    haskell = {
      formattingProvider = "ormolu",
    },
  },
})

-- astro: Astro Language Server (not managed by Mason)
vim.lsp.config("astro", {
  capabilities = capabilities,
  cmd = { "astro-ls", "--studio" },
  filetypes = { "astro" },
})

-- rust_analyzer: Rust Language Server
-- Try to use rust-tools if available, otherwise use standard config
local ok, rust_tools = pcall(require, "rust-tools")
if ok then
  rust_tools.setup({
    server = {
      capabilities = capabilities,
    },
  })
else
  vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
  })
end

-- Enable all LSP servers
-- Servers managed by Mason: ts_ls, terraformls, pyright
-- Servers with custom config: lua_ls, solargraph, rust_analyzer
-- Servers managed outside Mason: hls, astro
vim.lsp.enable({
  "ts_ls",
  "lua_ls",
  "rust_analyzer",
  "solargraph",
  "terraformls",
  "pyright",
  "hls",
  "astro",
})
