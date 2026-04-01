#!/bin/bash

set -ue

function is_homebrew_installed() {
  command -v brew >/dev/null 2>&1
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
  local brew_script="/tmp/homebrew-install.sh"
  local expected_sha256="dfd5145fe2aa5956a600e35848765273f5798ce6def01bd08ecec088a1268d91"

  curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/${brew_commit}/install.sh" \
    -o "$brew_script"

  # Verify SHA256 checksum before execution (update hash when bumping brew_commit)
  local actual_sha256
  actual_sha256=$(shasum -a 256 "$brew_script" | awk '{print $1}')
  if [ "$actual_sha256" != "$expected_sha256" ]; then
    echo "🚨ERROR🚨 Homebrew install script checksum mismatch!"
    echo "  expected: ${expected_sha256}"
    echo "  actual:   ${actual_sha256}"
    rm -f "$brew_script"
    exit 1
  fi

  /bin/bash "$brew_script"
  rm -f "$brew_script"

  # インストールが成功したか再確認
  if is_homebrew_installed; then
    echo "Homebrew installed successfully.🎉"
  else
    echo "🚨ERROR🚨 Homebrew installation failed. Please check the installation logs."
    exit 1
  fi
}

main "$@"
