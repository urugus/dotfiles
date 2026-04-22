#!/usr/bin/env bash

set -ue

SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
LIB_DIR="$SELF_DIR/lib/dotinstaller"

source "$LIB_DIR/utilfuncs.sh"
source "$LIB_DIR/pipeline.sh"

helpmsg() {
  print_default "Usage: $(basename "${BASH_SOURCE[0]:-$0}") [install|update|link] [--help|-h]"
  print_default "  install: link dotfiles + install packages for the current OS [default]"
  print_default "  update:  refresh OS-level packages"
  print_default "  link:    only symlink dotfiles and set git include"
  print_default ""
  print_default "Supported OS: macOS (Homebrew) and Linux/Debian-family (apt)."
}

# Compose the pipeline for a given (mode, os) pair.
# This is where the Composite pattern pays off: each branch is just an ordered
# list of leaf step names, no platform-specific branching inside the steps.
pipeline_for() {
  local mode="$1" os="$2"
  case "$mode:$os" in
    link:*)          echo link gitconfig ;;
    install:macos)   echo link gitconfig homebrew brewfile fonts mac-defaults aquaskk ;;
    install:linux)   echo link gitconfig apt neovim deno fonts ;;
    update:macos)    echo brewfile-update ;;
    update:linux)    echo apt-update ;;
    *)
      print_error "unsupported combination: mode=$mode os=$os"
      return 1
      ;;
  esac
}

main() {
  local mode=""
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help) helpmsg; exit 0 ;;
      install|update|link) mode="$1" ;;
      *) print_error "[ERROR] Invalid argument '$1'"; helpmsg; exit 1 ;;
    esac
    shift
  done
  : "${mode:=install}"

  local os
  os="$(current_os)"
  if [[ "$os" == "unknown" ]]; then
    print_error "unsupported OS: $(uname)"
    exit 1
  fi

  local steps
  read -r -a steps <<< "$(pipeline_for "$mode" "$os")"

  print_info "pipeline: mode=$mode os=$os steps=(${steps[*]})"
  run_pipeline "${steps[@]}"

  print_info ""
  print_info "#####################################################"
  print_info "dotinstaller '$mode' finished successfully"
  print_info "#####################################################"
}

main "$@"
