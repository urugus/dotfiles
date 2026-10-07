#!/usr/bin/env bash

# Read-only health check for the symlink layout. Exits non-zero on problems.

set -ue

LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)"
source "$LIB_DIR/utilfuncs.sh"
source "$LIB_DIR/links.sh"

problems=0

problem() {
  print_warning "$*"
  problems=$((problems + 1))
}

run() {
  check_legacy_config || problems=$((problems + 1))

  # Tracked entries that are not linked (or linked elsewhere).
  local src dest
  while IFS=$'\t' read -r src dest; do
    if [[ ! -L "$dest" ]]; then
      problem "missing link: $dest → $src"
    elif [[ "$(readlink "$dest")" != "$src" ]]; then
      problem "foreign link: $dest → $(readlink "$dest") (expected $src)"
    fi
  done < <(link_targets)

  # Links into the repo that are dangling or point at untracked entries.
  local link target
  while IFS= read -r link; do
    target=$(readlink "$link")
    [[ "$target" == "$REPO"/* ]] || continue
    if [[ ! -e "$link" ]]; then
      problem "dangling link: $link → $target"
    elif [[ -z "$(git -C "$REPO" ls-files -- "${target#"$REPO"/}" | head -1)" ]]; then
      problem "untracked link: $link → $target"
    fi
  done < <(find "$HOME" "$HOME/.config" -maxdepth 1 -type l 2>/dev/null)

  if (( problems > 0 )); then
    print_error "doctor: $problems problem(s) found"
    return 1
  fi
  print_success "doctor: all links OK"
}

run "$@"
