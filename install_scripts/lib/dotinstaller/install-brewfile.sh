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

  # Supply-chain hardening: pin to a specific commit on the install branch
  local brewfile_commit="723acc6f3e0db4677c03bb87c4ea33157d549e26"
  local expected_sha256="464d39329e5e13939861dab96fbaf64e30513ef4a0666b7edaf7784079ba6fa7"

  curl -o install.sh -fsSL \
    "https://raw.githubusercontent.com/rcmdnk/homebrew-file/${brewfile_commit}/install.sh"

  # Verify SHA256 checksum before execution (update hash when bumping commit)
  local actual_sha256
  actual_sha256=$(shasum -a 256 install.sh | awk '{print $1}')
  if [ "$actual_sha256" != "$expected_sha256" ]; then
    echo "🚨ERROR🚨 homebrew-file install script checksum mismatch!"
    echo "  expected: ${expected_sha256}"
    echo "  actual:   ${actual_sha256}"
    rm -f install.sh
    exit 1
  fi

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
