#!/bin/bash

# defaultsコマンドで設定を適用する関数
apply_defaults() {
  local domain="$1"
  local key="$2"
  local value="$3"

  # グローバル設定の場合、domainを '-g' に置き換え
  if [[ "$domain" == "global" ]]; then
    domain="-g"
  fi

  case "$value" in
    true|false)
      defaults write "$domain" "$key" -bool "$value"
      ;;
    ''|*[!0-9]*)
      defaults write "$domain" "$key" -string "$value"
      ;;
    *)
      defaults write "$domain" "$key" -int "$value"
      ;;
  esac
}

function main() {
  local current_dir
  current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  source $current_dir/utilfuncs.sh

  # 設定ファイルの指定
  SETTINGS_FILE="${current_dir}/mac_defaults.json"

  # 設定ファイルが存在するかチェック
  if [ ! -f "$SETTINGS_FILE" ]; then
    print_error "Error: Settings file '$SETTINGS_FILE' not found."
    exit 1
  fi

  # 設定ファイルを読み込んで適用
  parse_settings_file "$SETTINGS_FILE" | while read -r domain key value; do
    echo "Applying: $domain -> $key = $value"
    apply_defaults "$domain" "$key" "$value"
  done

  # Apply settings
  print_info "Restarting Dock & Finder to apply changes..."
  killall Dock
  killall Finder

  print_info "#####################################################"
  print_info "Initial settings configured successfully."
  print_info "#####################################################"
}

main "$@"
