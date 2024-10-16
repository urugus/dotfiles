#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function link_to_homedir() {
  print_notice "backup old dotfiles..."
  if [ ! -d "$HOME/.dotbackup" ];then
    command echo "$HOME/.dotbackup not found. Auto Make it"
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dotdir="$script_dir"
  local ignore_files=(".git" ".gitignore" ".DS_Store" ".gitmodules")

  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.[^.]*; do
      local basefile=$(basename $f)

      for ignore in "${ignore_files[@]}"; do
        if [[ "$basefile" == "$ignore" ]]; then
          command echo "Skipping $basefile"
          continue 2
        fi
      done

      if [[ -L "$HOME/$basefile" ]]; then
        command rm -f "$HOME/$basefile"
      fi

      if [[ -e "$HOME/$basefile" ]]; then
        command mv "$HOME/$basefile" "$HOME/.dotbackup"
      fi
      command ln -snf $f $HOME
    done
  else
    command echo "same install src dest"
  fi
  print_success "completed: symbolic link"
}

link_to_homedir
