# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Test Commands
- Setup dotfiles: `./setup.sh --install` or `./setup.sh --update`
- Ruby tests: `bundle exec rspec`
- Run tests for current file: `<Space>ta` (TestFile command)
- Run nearest test: `<Space>tl` (TestNearest command)

## Lint/Format Commands
- Linting: Runs automatically on BufWritePost and InsertLeave
- Formatting: Automatically applied on save with 5000ms timeout and LSP fallback
- Linters: Lua (selene), JS/TS (eslint_d), Ruby (rubocop), Python (flake8), Shell (shellcheck), Terraform (tflint)
- Formatters: JS/TS (prettierd), Ruby (rubocop), Python (black), Shell (shfmt), Lua (stylua), Terraform (terraform_fmt)

## Code Style
- Indent: 2 spaces (no tabs)
- Line endings: Unix
- Naming: Follow existing conventions (snake_case for Ruby, camelCase for JS)
- Editor: Neovim with extensive plugin configuration
- Git commit messages: Be concise and descriptive of changes
- Error handling: Follow language-specific idioms already used in the codebase