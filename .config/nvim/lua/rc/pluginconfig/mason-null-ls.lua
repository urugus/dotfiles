require("mason-null-ls").setup({
  automatic_installation = true,
  ensure_installed = {
    -- typescript
    "prettier",
    "eslint_d",
    -- Ruby
    "rubocop",
    "erb-formatter",
    "solargraph",
    "ruby-lsp",
    -- Python
    "flake8",
    -- Yaml
    "yamllint",
    "yamlfmt",
    -- Lua
    "stylua",
    "selene",
    -- Shell
    "shellcheck",
    "shfmt",
    -- Terraform
    "terraform_fmt",
    "tflint",
  },
})
