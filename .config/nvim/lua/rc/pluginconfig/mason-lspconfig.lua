-- LSP Keymappings and Inlay Hints
-- These are automatically applied when LSP attaches to a buffer
local group_name = "vimrc_lsp_attach"
vim.api.nvim_create_augroup(group_name, { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Enable inlay hints if supported
    if client and client.supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Keymappings
    local function buf_set_keymap(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      opts.noremap = true
      opts.silent = true
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- LSP keybindings
    -- Note: gd, gD, gr, gI, gy are mapped in mappings.lua using snacks.picker
    buf_set_keymap("n", "?", vim.lsp.buf.hover)
    buf_set_keymap("n", "g?", vim.lsp.buf.signature_help)
    buf_set_keymap("n", "[_Lsp]wa", vim.lsp.buf.add_workspace_folder)
    buf_set_keymap("n", "[_Lsp]wr", vim.lsp.buf.remove_workspace_folder)
    buf_set_keymap("n", "[_Lsp]wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
    buf_set_keymap("n", "[_Lsp]a", vim.lsp.buf.code_action)
    buf_set_keymap("n", "[_Lsp]e", vim.diagnostic.open_float)
    buf_set_keymap("n", "[d", vim.diagnostic.goto_prev)
    buf_set_keymap("n", "]d", vim.diagnostic.goto_next)
    buf_set_keymap("n", "[_Lsp]q", vim.diagnostic.setloclist)
    buf_set_keymap("n", "[_Lsp]f", vim.lsp.buf.format)
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
vim.lsp.config('lua_ls', {
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
vim.lsp.config('solargraph', {
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
vim.lsp.config('hls', {
  capabilities = capabilities,
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  settings = {
    haskell = {
      formattingProvider = "ormolu"
    }
  }
})

-- astro: Astro Language Server (not managed by Mason)
vim.lsp.config('astro', {
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
  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
  })
end

-- Enable all LSP servers
-- Servers managed by Mason: ts_ls, terraformls, pyright
-- Servers with custom config: lua_ls, solargraph, rust_analyzer
-- Servers managed outside Mason: hls, astro
vim.lsp.enable({
  'ts_ls',
  'lua_ls',
  'rust_analyzer',
  'solargraph',
  'terraformls',
  'pyright',
  'hls',
  'astro',
})
