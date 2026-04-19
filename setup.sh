#!/usr/bin/env bash

set -ue

SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

source "$SELF_DIR/install_scripts/lib/dotinstaller/utilfuncs.sh"

helpmsg() {
  print_default "Usage: $(basename "${BASH_SOURCE[0]:-$0}") [--install|-i] [--update|-u] [--help|-h]"
  print_default "  --install: bootstrap the host (link + install packages for current OS)"
  print_default "  --update:  refresh OS-level packages"
  print_default "  default:   prints this help"
}

main() {
  local mode=""
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help) helpmsg; exit 0 ;;
      -i|--install) mode="install" ;;
      -u|--update)  mode="update" ;;
      *) print_error "[ERROR] Invalid argument '$1'"; helpmsg; exit 1 ;;
    esac
    shift
  done

  if [[ -z "$mode" ]]; then
    helpmsg
    exit 1
  fi

  "$SELF_DIR/install_scripts/dotinstaller.sh" "$mode"
}

main "$@"
