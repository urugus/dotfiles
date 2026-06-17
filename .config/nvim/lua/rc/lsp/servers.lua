local capabilities_mod = require("rc.lsp.capabilities")

local M = {}

M.ensure_installed = { "ts_ls", "rust_analyzer", "lua_ls", "terraformls", "pyright", "solargraph" }

local function solargraph_root_dir(bufnr, on_dir)
  local root = vim.fs.root(bufnr, { { ".solargraph.yml", "Gemfile", ".git" } })
  if not root then
    return
  end

  -- ~/Gemfile を拾ってホーム全体を Ruby workspace にしない。
  if root == vim.uv.os_homedir() then
    return
  end

  on_dir(root)
end

local function solargraph_cmd()
  -- Prefer Homebrew because Mason 0.59.2 can hang while mapping workspaces.
  for _, path in ipairs({ "/opt/homebrew/bin/solargraph", "/usr/local/bin/solargraph" }) do
    if vim.fn.executable(path) == 1 then
      return { path, "stdio" }
    end
  end

  return { "solargraph", "stdio" }
end

local servers = {
  ts_ls = {},
  rust_analyzer = {},
  terraformls = {},
  pyright = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = { globals = { "vim" } },
        hint = { enable = true },
        runtime = { version = "LuaJIT" },
        telemetry = { enable = false },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
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
    cmd = solargraph_cmd(),
    root_dir = solargraph_root_dir,
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
    settings = {
      haskell = { formattingProvider = "ormolu" },
    },
  },
  astro = {},
}

local function with_cap(capabilities, config)
  return vim.tbl_deep_extend("force", { capabilities = capabilities }, config or {})
end

function M.setup(capabilities)
  local caps = capabilities or capabilities_mod.get()

  for name, cfg in pairs(servers) do
    vim.lsp.config(name, with_cap(caps, cfg))
  end

  vim.lsp.enable(vim.tbl_keys(servers))
end

return M
