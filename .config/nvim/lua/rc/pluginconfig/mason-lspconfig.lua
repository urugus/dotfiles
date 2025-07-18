require("mason-lspconfig").setup({
  ensure_installed = {
    "terraformls", -- Terraform LSP
    "lua_ls", -- Lua
    "ts_ls", -- TypeScript
    "pyright", -- Python
    "solargraph", -- Ruby
  },
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "?", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "g?", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "[_Lsp]wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "[_Lsp]wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "[_Lsp]wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "[_Lsp]D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  -- buf_set_keymap("n", "[_Lsp]rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "[_Lsp]a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "[_Lsp]e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "[_Lsp]q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap("n", "[_Lsp]f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local group_name = "vimrc_mason_lspconfig"
vim.api.nvim_create_augroup(group_name, { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
  group = group_name,
})

local lspconfig = require("lspconfig")
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

-- 事前に capabilities, on_attach を定義しておく
-- local capabilities = …
-- local on_attach    = …

mason.setup()
mason_lsp.setup({
  -- 必要なら ensure_installed にサーバー名を列挙
  ensure_installed = { "ts_ls", "rust_analyzer", "lua_ls" },

  handlers = {
    -- デフォルトハンドラ（全サーバー共通）
    function(server_name)
      -- rust_analyzer は rust-tools 経由でセットアップ
      if server_name == "rust_analyzer" then
        local ok, rust_tools = pcall(require, "rust-tools")
        if ok then
          rust_tools.setup({
            server = { capabilities = capabilities, on_attach = on_attach },
          })
        else
          lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end

      -- lua_ls はネームスペース付きで個別設定
      elseif server_name == "lua_ls" then
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
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

      -- solargraph は個別設定（無限リロード対策）
      elseif server_name == "solargraph" then
        lspconfig.solargraph.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          cmd = { "solargraph", "stdio" },
          filetypes = { "ruby" },
          root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
          init_options = {
            formatting = false,
            diagnostics = true,
            autoformat = false,
            completion = true,
          },
          settings = {
            solargraph = {
              useBundler = false, -- Bundlerを無効化して安定性向上
              transport = "stdio",
              logLevel = "warn",
              promptDownload = false,
              diagnostics = true,
              checkGemVersion = false,
              folding = false,
            },
          },
        })

      -- それ以外は lspconfig で標準設定
      else
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end
    end,
  },
})
