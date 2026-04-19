#!/usr/bin/env bash

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

run() {
  git config --global include.path "$HOME/.config/git/gitconfig_shared"
  print_success "git include.path → $HOME/.config/git/gitconfig_shared"
}

run "$@"
