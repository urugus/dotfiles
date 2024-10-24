#!/usr/bin/env bash

set -ue

source "$(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh"

function link_to_homedir() {
  print_notice "Backup old dotfiles..."

  if [ ! -d "$HOME/.dotbackup" ]; then
    command echo "$HOME/.dotbackup not found. Auto creating it..."
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dotdir="$script_dir"
  local ignore_files=(".git" ".gitignore" ".DS_Store" ".gitmodules")

  if [[ "$HOME" != "$dotdir" ]]; then
    # 隠しファイルと隠しディレクトリを対象にする
    for f in "$dotdir"/.[!.]*; do
      local basefile=$(basename "$f")

      # ignore_filesリストを使って無視すべきファイルをスキップ
      if [[ " ${ignore_files[@]} " =~ " $basefile " ]]; then
        command echo "Skipping $basefile"
        continue
      fi

      # 既存のシンボリックリンクを削除
      if [[ -L "$HOME/$basefile" ]]; then
        command rm -f "$HOME/$basefile"
      fi

      # 既存のファイルやディレクトリをバックアップ
      if [[ -e "$HOME/$basefile" ]]; then
        command mv "$HOME/$basefile" "$HOME/.dotbackup"
      fi

      # シンボリックリンクの作成
      command ln -snf "$f" "$HOME/$basefile"
    done
  else
    command echo "Install source and destination are the same."
  fi
  print_success "Completed: symbolic link"
}

link_to_homedir

