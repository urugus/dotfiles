-- LSP server configuration for Neovim 0.11+ (new LSP API)

local capabilities_mod = require("rc.lsp.capabilities")

local M = {}

-- Mason で確実に入れておきたいサーバー
M.ensure_installed = { "ts_ls", "rust_analyzer", "lua_ls", "terraformls", "pyright", "solargraph" }

local default_servers = { "ts_ls", "terraformls", "pyright" }

local server_configs = {
  lua_ls = {
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
  },
  solargraph = {
    cmd = { "solargraph", "stdio" },
    filetypes = { "ruby" },
    init_options = {
      formatting = false,
      diagnostics = false,
      autoformat = false,
      completion = true,
    },
    settings = {
      solargraph = {
        useBundler = false,
        transport = "stdio",
        logLevel = "warn",
        promptDownload = false,
        diagnostics = false,
        checkGemVersion = false,
        folding = false,
      },
    },
  },
  hls = {
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell" },
    settings = {
      haskell = { formattingProvider = "ormolu" },
    },
  },
  astro = {
    cmd = { "astro-ls", "--studio" },
    filetypes = { "astro" },
  },
  rust_analyzer = {
    -- handled separately to prefer rust-tools when available
  },
}

local function with_cap(capabilities, config)
  return vim.tbl_deep_extend("force", { capabilities = capabilities }, config or {})
end

-- rust_analyzer のセットアップ（rust-tools があればそれを優先）
-- @return boolean rust-tools が使用された場合は true
local function setup_rust_analyzer(caps)
  local rust_cfg = with_cap(caps, server_configs.rust_analyzer)
  local ok, rust_tools = pcall(require, "rust-tools")

  if ok then
    rust_tools.setup({ server = rust_cfg })
    return true
  end

  vim.lsp.config("rust_analyzer", rust_cfg)
  return false
end

function M.setup(capabilities)
  local caps = capabilities or capabilities_mod.get()

  -- server_configs にあるものを設定（rust_analyzer以外）
  for name, cfg in pairs(server_configs) do
    if name ~= "rust_analyzer" then
      vim.lsp.config(name, with_cap(caps, cfg))
    end
  end

  -- default_servers で server_configs にないものも設定
  for _, name in ipairs(default_servers) do
    if not server_configs[name] then
      vim.lsp.config(name, with_cap(caps))
    end
  end

  -- rust_analyzer セットアップ
  local rust_tools_enabled = setup_rust_analyzer(caps)

  -- rust-tools が有効な場合は rust_analyzer を除外
  local servers_to_enable = {
    "ts_ls",
    "lua_ls",
    "solargraph",
    "terraformls",
    "pyright",
    "hls",
    "astro",
  }
  if not rust_tools_enabled then
    table.insert(servers_to_enable, "rust_analyzer")
  end
  vim.lsp.enable(servers_to_enable)
end

return M
