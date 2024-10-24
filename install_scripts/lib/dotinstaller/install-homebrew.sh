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
    exit 1
  fi

  echo "Homebrew is not installed. Installing Homebrew..."
  # Homebrewのインストール
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # インストールが成功したか再確認
  if is_homebrew_installed; then
    echo "Homebrew installed successfully.🎉"
  else
    echo "🚨ERROR🚨 Homebrew installation failed. Please check the installation logs."
    exit 1
  fi
}

main "$@"
