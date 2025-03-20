require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    ruby = { "rubocop" },
    python = { "black" },
    sh = { "shfmt" },
    yaml = { "yamlfmt" },
    lua = { "stylua" },
  },
  formatters = {
    rubocop = {
      command = "sh",
      args = {
        "-c",
        [[
        docker-compose exec rspec bundle exec rubocop -a --stdin %filepath% | sed -n '/^====================$/,$p' | sed '1d'
        ]],
      },
      stdin = true,
      timeout = 10000, -- 10秒に延長（大きなファイル用）
    },
  },
  format_on_save = {
    timeout_ms = 5000, -- 5秒に延長
    lsp_fallback = true, -- LSPのフォーマッタをフォールバックとして使用
  },
})
