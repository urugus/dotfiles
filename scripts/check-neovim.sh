#!/usr/bin/env bash
set -euo pipefail

if ! command -v nvim >/dev/null 2>&1; then
  echo "nvim command not found in PATH" >&2
  exit 1
fi

unset NVIM_LISTEN_ADDRESS

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Ensure tilde-expansion inside the config resolves to the repository copy.
export HOME="${HOME_OVERRIDE:-$REPO_ROOT}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$REPO_ROOT/.config"}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-"$REPO_ROOT/.local/share"}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-"$REPO_ROOT/.local/state"}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$REPO_ROOT/.cache"}"

mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

health_log="$tmpdir/nvim-checkhealth.log"
messages_log="$tmpdir/nvim-messages.log"

if [[ "${SKIP_LAZY_SYNC:-0}" != "1" ]]; then
  if ! nvim --headless -c "Lazy! sync" -c "qa"; then
    echo "lazy.nvim sync failed" >&2
    exit 1
  fi
fi

if ! NVIM_MESSAGES_LOG="$messages_log" \
    nvim --headless \
      -c "checkhealth vim.deprecated" \
      -c "lua do local out = vim.api.nvim_exec2('messages', {output = true}).output; vim.fn.writefile(vim.split(out, '\n', {trimempty = true}), vim.env.NVIM_MESSAGES_LOG) end" \
      -c "qa" \
      >"$health_log" 2>&1; then
  cat "$health_log"
  echo "Neovim health check failed" >&2
  exit 1
fi

status=0

# WARNINGは外部プラグイン由来の可能性があるため情報表示のみ
if grep -q "WARNING" "$health_log" 2>/dev/null; then
  echo "Neovim checkhealth reported warnings (informational only):"
  cat "$health_log"
  echo ""
fi

# ERRORのみを失敗条件とする
if grep -q "ERROR" "$health_log" 2>/dev/null; then
  echo "Neovim checkhealth reported errors:"
  cat "$health_log"
  status=1
fi

if grep -Eq "^E[0-9]" "$messages_log" >/dev/null 2>&1; then
  echo "Neovim emitted error messages during startup:"
  cat "$messages_log"
  status=1
fi

exit "$status"
