#!/usr/bin/env bash

# Install Deno from upstream release archives.
#
# Required by the denops.vim runtime that several Neovim plugins
# (skkeleton, etc.) depend on.

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

DENO_VERSION="${DENO_VERSION:-v2.7.12}"
BIN_PATH="/usr/local/bin/deno"

run() {
  local arch_triple zip url tmpdir
  case "$(uname -m)" in
    aarch64|arm64) arch_triple="aarch64-unknown-linux-gnu" ;;
    x86_64|amd64)  arch_triple="x86_64-unknown-linux-gnu" ;;
    *) print_error "unsupported arch: $(uname -m)"; return 1 ;;
  esac

  if [[ -x "$BIN_PATH" ]] && "$BIN_PATH" --version | head -1 | grep -qF "${DENO_VERSION#v}"; then
    print_success "deno ${DENO_VERSION} already installed at $BIN_PATH"
    return 0
  fi

  zip="deno-${arch_triple}.zip"
  url="https://github.com/denoland/deno/releases/download/${DENO_VERSION}/${zip}"
  tmpdir="$(mktemp -d)"
  # shellcheck disable=SC2064
  trap "rm -rf '$tmpdir'" EXIT

  print_info "downloading $url"
  curl -fsSL "$url" -o "$tmpdir/$zip"
  unzip -q "$tmpdir/$zip" -d "$tmpdir"

  print_info "installing to $BIN_PATH"
  run_privileged install -m 0755 "$tmpdir/deno" "$BIN_PATH"

  print_success "deno $("$BIN_PATH" --version | head -1) installed"
}

run "$@"
