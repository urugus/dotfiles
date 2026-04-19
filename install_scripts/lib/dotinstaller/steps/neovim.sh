#!/usr/bin/env bash

# Install Neovim from the upstream prebuilt tarball.
#
# Debian/Ubuntu's apt neovim lags behind the dotfiles requirements
# (denops needs >= 0.11.3, treesitter config targets 0.12). We pin a
# known-good upstream release and install it under /opt/nvim with a
# /usr/local/bin/nvim symlink so PATH picks it up over the apt binary.

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

NVIM_VERSION="${NVIM_VERSION:-v0.12.1}"
PREFIX="/opt/nvim"
BIN_LINK="/usr/local/bin/nvim"

run() {
  local arch tarball url tmpdir
  case "$(uname -m)" in
    aarch64|arm64) arch="arm64" ;;
    x86_64|amd64)  arch="x86_64" ;;
    *) print_error "unsupported arch: $(uname -m)"; return 1 ;;
  esac

  if [[ -x "$PREFIX/bin/nvim" ]] && "$PREFIX/bin/nvim" --version | head -1 | grep -qF "${NVIM_VERSION#v}"; then
    print_success "neovim ${NVIM_VERSION} already installed at $PREFIX"
    run_privileged ln -sfn "$PREFIX/bin/nvim" "$BIN_LINK"
    return 0
  fi

  tarball="nvim-linux-${arch}.tar.gz"
  url="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${tarball}"
  tmpdir="$(mktemp -d)"
  # shellcheck disable=SC2064
  trap "rm -rf '$tmpdir'" EXIT

  print_info "downloading $url"
  curl -fsSL "$url" -o "$tmpdir/$tarball"

  print_info "installing to $PREFIX"
  run_privileged rm -rf "$PREFIX"
  run_privileged mkdir -p "$PREFIX"
  run_privileged tar -xzf "$tmpdir/$tarball" -C "$PREFIX" --strip-components=1
  run_privileged ln -sfn "$PREFIX/bin/nvim" "$BIN_LINK"

  print_success "neovim $("$PREFIX/bin/nvim" --version | head -1) installed"
}

run "$@"
