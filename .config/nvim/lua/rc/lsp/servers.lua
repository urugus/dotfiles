local capabilities_mod = require("rc.lsp.capabilities")

local M = {}

-- Mason で確実に入れておきたいサーバー
M.ensure_installed = { "ts_ls", "rust_analyzer", "lua_ls", "terraformls", "pyright", "solargraph" }

-- 1サーバー分の config に capabilities を付与
local function with_cap(capabilities, config)
  return vim.tbl_deep_extend("force", { capabilities = capabilities }, config or {})
end

function M.setup(capabilities)
  local caps = capabilities or capabilities_mod.get()

  -- 汎用サーバー（特別な設定なし）
  for _, name in ipairs({ "ts_ls", "terraformls", "pyright" }) do
    vim.lsp.config(name, with_cap(caps))
  end

  -- 個別設定
  vim.lsp.config(
    "lua_ls",
    with_cap(caps, {
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
  )

  vim.lsp.config(
    "solargraph",
    with_cap(caps, {
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
    })
  )

  vim.lsp.config(
    "hls",
    with_cap(caps, {
      cmd = { "haskell-language-server-wrapper", "--lsp" },
      filetypes = { "haskell", "lhaskell" },
      settings = {
        haskell = { formattingProvider = "ormolu" },
      },
    })
  )

  vim.lsp.config(
    "astro",
    with_cap(caps, {
      cmd = { "astro-ls", "--studio" },
      filetypes = { "astro" },
    })
  )

  -- rust_analyzer: rust-tools があればそれを優先
  local rust_config = { capabilities = caps }
  local ok, rust_tools = pcall(require, "rust-tools")
  if ok then
    rust_tools.setup({ server = rust_config })
  else
    vim.lsp.config("rust_analyzer", rust_config)
  end

  -- 有効化
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
end

return M
