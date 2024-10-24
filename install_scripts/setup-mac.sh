
#!/bin/bash
set -ue

#--------------------------------------------------------------#
##          main                                              ##
#--------------------------------------------------------------#

function main() {
  local current_dir
  current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  source $current_dir/lib/dotinstaller/utilfuncs.sh
  # MacOS以外の場合はエラー
  if ! is_macos; then
    print_error "This script is only for macOS"
    exit 1
  fi

  "${current_dir}"/lib/dotinstaller/mac-setting.sh
}

main "$@"
