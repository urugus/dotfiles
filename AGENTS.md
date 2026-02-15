# Agent Guidelines

Always prefer simplicity over pathological correctness.
YAGNI, KISS, DRY. 
No backwords-compat shims or fallback paths unless they comes free without adding cyclomatic complexity.

# Repository Guidelines

## Project Structure & Module Organization
- `.config/nvim/` hosts the Neovim profile; Lua modules under `lua/rc/` define plugins, keymaps, and options.
- `.config/zsh/rc/` splits shell setup into focused fragments (`alias.zsh`, `bindkey.zsh`, etc.) while helpers live under `.config/zsh/functions/`.
- `.config/wezterm/` and `.config/ghostty/` hold terminal themes; update both when changing keymaps or palettes.
- `install_scripts/` houses provisioning; `dotinstaller.sh` handles Homebrew bundles plus linking, fonts, and Mac defaults via `lib/dotinstaller/`.
- `.github/workflows/gitguardian.yml` runs GitGuardian on push/PR; keep secrets out of version control.

## Build, Test, and Development Commands
- `./setup.sh --install` bootstraps a macOS host: installs Homebrew, fonts, and links dotfiles.
- `./setup.sh --update` refreshes packages through `brew file update`; use after touching the Brewfile.
- `./install_scripts/dotinstaller.sh link` relinks configs without reinstalling packages, ideal for local iteration.
- `mise run rs` / `mise run rc` trigger the Docker-backed Ruby tasks from `.config/mise/config.toml`; ensure the companion compose services are up.
- `stylua .config/nvim` keeps Lua formatting consistent with `stylua.toml`; add `--check` to gate CI.

## Coding Style & Naming Conventions
- Shell scripts prefer `bash`, start with `set -ue`, and use kebab-case filenames.
- Lua follows `stylua.toml` (two-space, Unix EOL); lint via `selene -c selene.toml`.
- Zsh aliases stay lowercase and hyphen separated; group related entries inside `alias.zsh` for discoverability.
- Append new Brewfile entries alphabetically to reduce merge noise.

## Testing Guidelines
- After editing provisioning scripts, run `./install_scripts/dotinstaller.sh link` and launch a fresh shell to confirm prompts, aliases, and environment hooks.
- Validate Neovim updates with `nvim --headless "+Lazy sync" +qa` to ensure plugin specs resolve cleanly.
- Use `mise run rr` to execute Dockerized RSpec and RuboCop when touching shared Ruby tooling.
- Monitor GitGuardian workflow results on PRs and resolve any leak alerts before review.

## Commit & Pull Request Guidelines
- Follow the `<area>: <imperative>` commit style adopted in history (`neovim: update plugins`, `ghostty: tweak theme`).
- PRs should summarize scope, list manual verification commands (`./setup.sh --install`, `nvim --headless ...`), and attach screenshots for visual terminal changes.
- Reference related issues or tickets and flag external dependencies (Docker, Homebrew taps) reviewers must prepare.
- Seek review for changes under `install_scripts/` or `.config/brewfile/`, as they impact machine setup.

## Security & Configuration Tips
- Store machine-specific secrets in environment files or keychain entries; never commit values that would trip GitGuardian.
- Document tweaks to `install_scripts/lib/dotinstaller/mac_defaults.json` and test via `install_scripts/lib/dotinstaller/mac-setting.sh` before merging.
