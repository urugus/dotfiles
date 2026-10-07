#!/usr/bin/env bash

set -ue

LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)"
source "$LIB_DIR/utilfuncs.sh"
source "$LIB_DIR/links.sh"

# Create a symlink $dest → $src, idempotent and non-destructive.
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
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  print_success "link $dest → $src"
}

run() {
  require_repo
  check_legacy_config
  local src dest
  while IFS=$'\t' read -r src dest; do
    link_one "$src" "$dest"
  done < <(link_targets)
}

run "$@"
