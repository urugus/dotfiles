#!/usr/bin/env bash

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

REPO="$HOME/dotfiles"

# Entries under $REPO that must never be linked to $HOME.
IGNORE=(".git" ".gitignore" ".gitmodules" ".github" ".DS_Store" ".claude")

is_ignored() {
  local entry="$1" x
  for x in "${IGNORE[@]}"; do
    [[ "$x" == "$entry" ]] && return 0
  done
  return 1
}

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

# Link each immediate child of $REPO/.config/ individually so an existing
# $HOME/.config directory (often populated by other tools) is preserved.
link_config_children() {
  local sub name
  shopt -s nullglob
  for sub in "$REPO/.config/"* "$REPO/.config/".??*; do
    name="${sub##*/}"
    link_one "$sub" "$HOME/.config/$name"
  done
  shopt -u nullglob
}

run() {
  if [[ ! -d "$REPO" ]]; then
    print_error "repo not found at $REPO"
    return 1
  fi
  local entry
  shopt -s nullglob
  for entry in "$REPO"/.??*; do
    local name="${entry##*/}"
    if is_ignored "$name"; then
      continue
    fi
    if [[ "$name" == ".config" ]]; then
      link_config_children
    else
      link_one "$entry" "$HOME/$name"
    fi
  done
  shopt -u nullglob
}

run "$@"
