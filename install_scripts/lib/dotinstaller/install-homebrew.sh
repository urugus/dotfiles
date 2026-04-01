#!/bin/bash

set -ue

function is_homebrew_installed() {
  command -v brew >/dev/null 2>&1
}

_sha256() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

function main() {
  local current_dir
  current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  source "$current_dir/utilfuncs.sh"

  if is_homebrew_installed; then
    return 0
  fi

  echo "Homebrew is not installed. Installing Homebrew..."

  # Supply-chain hardening: pin to a specific commit instead of HEAD
  local brew_commit="6d5e2670d07961e7985d2079a2f0a484420f3c38"
  local expected_sha256="dfd5145fe2aa5956a600e35848765273f5798ce6def01bd08ecec088a1268d91"
  local brew_script
  brew_script=$(mktemp)
  trap 'rm -f "$brew_script"' EXIT

  curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/${brew_commit}/install.sh" \
    -o "$brew_script"

  # Verify SHA256 checksum before execution (update hash when bumping brew_commit)
  local actual_sha256
  actual_sha256=$(_sha256 "$brew_script")
  if [ "$actual_sha256" != "$expected_sha256" ]; then
    echo "🚨ERROR🚨 Homebrew install script checksum mismatch!"
    echo "  expected: ${expected_sha256}"
    echo "  actual:   ${actual_sha256}"
    exit 1
  fi

  /bin/bash "$brew_script"

  # インストールが成功したか再確認
  if is_homebrew_installed; then
    echo "Homebrew installed successfully.🎉"
  else
    echo "🚨ERROR🚨 Homebrew installation failed. Please check the installation logs."
    exit 1
  fi
}

main "$@"
