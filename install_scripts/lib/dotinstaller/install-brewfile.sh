#!/bin/bash

set -ue

function is_brewfile_installed() {
  command -v brew-file >/dev/null 2>&1
}

function main() {
  local current_dir
  current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  source "$current_dir/utilfuncs.sh"

  if is_brewfile_installed; then
    return 0
  fi

  echo "Brewfile is not installed. Installing Brewfile..."
  # Brewfileのインストール
  curl -o install.sh -fsSL https://raw.github.com/rcmdnk/homebrew-file/install/install.sh
  chmod 755 ./install.sh
   ./install.sh
  rm -f install.sh

  # インストールが成功したか再確認
  if is_brewfile_installed; then
    echo "Brewfile installed successfully.🎉"
  else
    echo "🚨ERROR🚨 Brewfile installation failed. Please check the installation logs."
    exit 1
  fi
}

main "$@"
