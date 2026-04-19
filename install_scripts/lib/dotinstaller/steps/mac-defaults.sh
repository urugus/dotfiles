#!/usr/bin/env bash

set -ue

SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
LIB_DIR="$(cd "$SELF_DIR/.." && pwd)"
source "$LIB_DIR/utilfuncs.sh"

# mac_defaults.json lives alongside utilfuncs.sh (one level up from steps/).
SETTINGS_FILE="$LIB_DIR/mac_defaults.json"

apply_defaults() {
  local domain="$1" key="$2" value="$3"
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

run() {
  if ! is_macos; then
    print_warning "mac-defaults step skipped (non-macOS host)"
    return 0
  fi

  if [ ! -f "$SETTINGS_FILE" ]; then
    print_error "settings file not found: $SETTINGS_FILE"
    return 1
  fi

  parse_settings_file "$SETTINGS_FILE" | while read -r domain key value; do
    echo "Applying: $domain -> $key = $value"
    apply_defaults "$domain" "$key" "$value"
  done

  print_info "Restarting Dock & Finder..."
  killall Dock || true
  killall Finder || true
  print_success "mac defaults applied"
}

run "$@"
