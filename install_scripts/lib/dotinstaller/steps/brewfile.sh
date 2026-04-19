#!/usr/bin/env bash

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

_sha256() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

install_brew_file_cli() {
  if command -v brew-file >/dev/null 2>&1; then
    return 0
  fi

  print_info "brew-file is not installed. Installing..."

  local brewfile_commit="723acc6f3e0db4677c03bb87c4ea33157d549e26"
  local expected_sha256="464d39329e5e13939861dab96fbaf64e30513ef4a0666b7edaf7784079ba6fa7"
  local install_script
  install_script=$(mktemp "${TMPDIR:-/tmp}/brewfile-install.XXXXXX")
  trap 'rm -f "$install_script"' EXIT

  curl -fsSL -o "$install_script" \
    "https://raw.githubusercontent.com/rcmdnk/homebrew-file/${brewfile_commit}/install.sh"

  local actual_sha256
  actual_sha256=$(_sha256 "$install_script")
  if [ "$actual_sha256" != "$expected_sha256" ]; then
    print_error "🚨 homebrew-file install script checksum mismatch!"
    print_error "  expected: ${expected_sha256}"
    print_error "  actual:   ${actual_sha256}"
    exit 1
  fi

  chmod 755 "$install_script"
  "$install_script"

  if ! command -v brew-file >/dev/null 2>&1; then
    print_error "🚨 brew-file installation failed."
    exit 1
  fi
  print_success "brew-file installed 🎉"
}

run() {
  install_brew_file_cli
  brew file install
}

run "$@"
