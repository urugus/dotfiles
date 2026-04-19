#!/usr/bin/env bash

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

run() {
  if ! command -v apt-get >/dev/null 2>&1; then
    print_error "apt-get not found; this step requires a Debian/Ubuntu host"
    return 1
  fi
  run_privileged env DEBIAN_FRONTEND=noninteractive apt-get update
  run_privileged env DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
  print_success "apt packages upgraded"
}

run "$@"
