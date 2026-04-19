#!/usr/bin/env bash

set -ue

source "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)/utilfuncs.sh"

_sha256() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

verify_checksum() {
  local file="$1" expected="$2"
  local actual
  actual=$(_sha256 "$file")
  if [ "$actual" != "$expected" ]; then
    print_error "🚨 Checksum mismatch for ${file}!"
    print_error "  expected: ${expected}"
    print_error "  actual:   ${actual}"
    rm -f "$file"
    exit 1
  fi
}

# Download + verify + extract a font zip into ~/.local/share/fonts/$name.
fetch_font() {
  local name="$1" url="$2" sha256="$3"
  mkdir -p "$HOME/.local/share/fonts/$name"
  curl -fL -o "$FONT_TMPDIR/$name.zip" "$url"
  verify_checksum "$FONT_TMPDIR/$name.zip" "$sha256"
  (cd "$FONT_TMPDIR" && unzip -j -o "$name.zip" -d "$HOME/.local/share/fonts/$name")
}

run() {
  if ! command -v unzip >/dev/null 2>&1; then
    print_error "unzip not found; install unzip first"
    return 1
  fi

  FONT_TMPDIR=$(mktemp -d "${TMPDIR:-/tmp}/dotinstaller-fonts.XXXXXX")
  trap 'rm -rf "$FONT_TMPDIR"' EXIT

  fetch_font "UDEVGothic" \
    "https://github.com/yuru7/udev-gothic/releases/download/v2.2.0/UDEVGothic_v2.2.0.zip" \
    "c104c171f6ed8922ca52d74cd915a271e427f1e884e51431aae71d99e8b3b47b"

  fetch_font "HackNerdFont" \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip" \
    "8ca33a60c791392d872b80d26c42f2bfa914a480f9eb2d7516d9f84373c36897"

  fetch_font "FiraCode" \
    "https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip" \
    "0949915ba8eb24d89fd93d10a7ff623f42830d7c5ffc3ecbf960e4ecad3e3e79"

  if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -vf
  else
    print_warning "fc-cache not installed; skipping font cache refresh"
  fi
}

run "$@"
