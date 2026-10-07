#!/usr/bin/env bash

# Shared helpers for the link and doctor steps.
#
# Only git-tracked entries are linked. Anything a tool drops into the repo
# (caches, logs, app state) stays untracked and is never exposed under $HOME.

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

# Print unique first path components of tracked files under $1 ("" = repo root).
tracked_children() {
  local prefix="$1"
  git -C "$REPO" -c core.quotePath=false ls-files -- "${prefix:-.}" \
    | sed "s|^${prefix:+$prefix/}||" | cut -d/ -f1 | sort -u
}

# Print "src<TAB>dest" for every link the repo should provide.
# Top-level dot entries map to $HOME/<name>; each child of .config maps to
# $HOME/.config/<name> so $HOME/.config stays a real directory.
link_targets() {
  local name
  while IFS= read -r name; do
    [[ "$name" == .* ]] || continue
    is_ignored "$name" && continue
    [[ "$name" == ".config" ]] && continue
    printf '%s\t%s\n' "$REPO/$name" "$HOME/$name"
  done < <(tracked_children "")
  while IFS= read -r name; do
    is_ignored "$name" && continue
    printf '%s\t%s\n' "$REPO/.config/$name" "$HOME/.config/$name"
  done < <(tracked_children ".config")
}

# The old layout symlinked $HOME/.config to $REPO/.config as a whole, which
# puts every app's state inside the repo and breaks apps that reject
# non-canonical paths (e.g. AWS VPN Client >= 6.2).
check_legacy_config() {
  if [[ -L "$HOME/.config" && "$(readlink "$HOME/.config")" == "$REPO/.config" ]]; then
    print_error "$HOME/.config is a symlink to $REPO/.config (legacy layout)."
    print_error "Migrate: mv ~/.config ~/.config.bak-link && mkdir ~/.config,"
    print_error "move untracked entries of $REPO/.config into ~/.config, then re-run link."
    return 1
  fi
}
