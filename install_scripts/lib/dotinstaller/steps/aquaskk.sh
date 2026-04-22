#!/usr/bin/env bash

# Symlink AquaSKK shareable config into ~/Library/Application Support/AquaSKK/.
# The personal learned dictionary (skk-jisyo.utf8 / ~/.skk-jisyo) stays outside
# the repo for privacy.

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

if ! is_macos; then
  print_info "skipping aquaskk (macOS only)"
  exit 0
fi

REPO_DIR="$HOME/dotfiles/.config/skk/aquaskk"
TARGET_DIR="$HOME/Library/Application Support/AquaSKK"

FILES=(
  "keymap.conf"
  "BlacklistApps.plist"
  "DictionarySet.plist"
)

link_one() {
  local src="$1" dest="$2"
  if [[ -L "$dest" ]]; then
    local cur
    cur=$(readlink "$dest")
    if [[ "$cur" != "$src" ]]; then
      print_warning "skip $dest (symlink → $cur, expected $src)"
    fi
    return 0
  fi
  if [[ -e "$dest" ]]; then
    print_warning "skip $dest (exists; move it aside to link)"
    return 0
  fi
  ln -s "$src" "$dest"
  print_success "link $dest → $src"
}

run() {
  if [[ ! -d "$REPO_DIR" ]]; then
    print_error "repo dir not found: $REPO_DIR"
    return 1
  fi
  mkdir -p "$TARGET_DIR"
  local f
  for f in "${FILES[@]}"; do
    link_one "$REPO_DIR/$f" "$TARGET_DIR/$f"
  done
}

run "$@"
