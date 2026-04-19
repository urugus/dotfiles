#!/usr/bin/env bash

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

# Minimal package set to boot the dotfiles on Debian/Ubuntu-family hosts.
# Additional language runtimes (rbenv, rustup, node, etc.) are expected to be
# layered on top via mise or their official installers.
PACKAGES=(
  build-essential
  ca-certificates
  curl
  wget
  git
  zsh
  neovim
  tmux
  unzip
  jq
  fzf
  ripgrep
  fd-find
  bat
  fontconfig
  tig
  tree
  python3
  python3-pip
)

run() {
  if ! command -v apt-get >/dev/null 2>&1; then
    print_error "apt-get not found; this step requires a Debian/Ubuntu host"
    return 1
  fi

  run_privileged env DEBIAN_FRONTEND=noninteractive apt-get update
  run_privileged env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends "${PACKAGES[@]}"
  print_success "apt packages installed"
}

run "$@"
