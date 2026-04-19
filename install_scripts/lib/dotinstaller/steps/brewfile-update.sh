#!/usr/bin/env bash

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

run() {
  if ! command -v brew-file >/dev/null 2>&1; then
    print_error "brew-file not installed; run install pipeline first"
    return 1
  fi
  brew file update
}

run "$@"
