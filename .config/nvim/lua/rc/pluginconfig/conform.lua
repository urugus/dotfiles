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
    },
  },
  format_on_save = {
    timeout_ms = 1200,
    -- lsp_fallback = true,
  },
})
