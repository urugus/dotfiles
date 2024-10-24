#!/bin/bash

function print_default() {
  echo -e "$*"
}

function print_info() {
  echo -e "\e[1;36m$*\e[m" # cyan
}

function print_notice() {
  echo -e "\e[1;35m$*\e[m" # magenta
}

function print_success() {
  echo -e "\e[1;32m$*\e[m" # green
}

function print_warning() {
  echo -e "\e[1;33m$*\e[m" # yellow
}

function print_error() {
  echo -e "\e[1;31m$*\e[m" # red
}

function print_debug() {
  echo -e "\e[1;34m$*\e[m" # blue
}

function chkcmd() {
if ! builtin command -v "$1"; then
  print_error "${1} command not found"
  exit
fi
}

function yes_or_no_select() {
local answer
print_notice "Are you ready? [yes/no]"
read -r answer
case $answer in
  yes | y)
    return 0
    ;;
  no | n)
    return 1
    ;;
  *)
    yes_or_no_select
    ;;
esac
}

# 設定ファイルを読み込み、設定ペアを返す関数
parse_settings_file() {
  local file="$1"
  local ext="${file##*.}"

  case "$ext" in
    json)
      jq -r 'to_entries[] | "\(.key) \(.value | to_entries[] | "\(.key) \(.value)")"' "$file"
      ;;
    yml|yaml)
      yq -r 'to_entries[] | "\(.key) \(.value | to_entries[] | "\(.key) \(.value)")"' "$file"
      ;;
    *)
      echo "Unsupported file format. Please use .json or .yml"
      exit 1
      ;;
  esac
}

# macOS環境かどうかをチェックする関数
is_macos() {
  if [[ "$(uname)" == "Darwin" ]]; then
    return 0  # macOSの場合
  else
    return 1  # macOS以外の場合
  fi
}
