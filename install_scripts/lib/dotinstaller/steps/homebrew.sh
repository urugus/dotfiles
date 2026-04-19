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

run() {
  if command -v brew >/dev/null 2>&1; then
    return 0
  fi

  print_info "Homebrew is not installed. Installing Homebrew..."

  # Supply-chain hardening: pin to a specific commit instead of HEAD
  local brew_commit="6d5e2670d07961e7985d2079a2f0a484420f3c38"
  local expected_sha256="dfd5145fe2aa5956a600e35848765273f5798ce6def01bd08ecec088a1268d91"
  local brew_script
  brew_script=$(mktemp -t brew_install.XXXXXX)
  trap 'rm -f "$brew_script"' EXIT

  curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/${brew_commit}/install.sh" \
    -o "$brew_script"

  local actual_sha256
  actual_sha256=$(_sha256 "$brew_script")
  if [ "$actual_sha256" != "$expected_sha256" ]; then
    print_error "🚨 Homebrew install script checksum mismatch!"
    print_error "  expected: ${expected_sha256}"
    print_error "  actual:   ${actual_sha256}"
    exit 1
  fi

  /bin/bash "$brew_script"

  if command -v brew >/dev/null 2>&1; then
    print_success "Homebrew installed 🎉"
  else
    print_error "🚨 Homebrew installation failed."
    exit 1
  fi
}

run "$@"
