#!/usr/bin/env bash

set -ue

source "$(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh"

function create_symbolic_link() {
  link="$1"

  if [[ ! -L  "$HOME/$link" ]]; then
    ln -snf "$HOME/dotfiles/$link" "$HOME/$link"
  fi
}

function main() {
  dotfiles=$(ls -d .??*)
  ignore_files=(".git" ".gitignore" ".DS_Store" ".gitmodules")

  for file in $dotfiles; do
    if [[ ! " ${ignore_files[@]} " =~ " ${file} " ]]; then
      create_symbolic_link "$file"
    fi
  done
}

main "$@"
