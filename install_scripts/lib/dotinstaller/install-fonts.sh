#!/usr/bin/env bash

set -ue

# Supply-chain hardening: pin font releases and verify checksums
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
    echo "🚨ERROR🚨 Checksum mismatch for ${file}!"
    echo "  expected: ${expected}"
    echo "  actual:   ${actual}"
    rm -f "$file"
    exit 1
  fi
}

FONT_TMPDIR=$(mktemp -d)
trap 'rm -rf "$FONT_TMPDIR"' EXIT

mkdir -p ~/.local/share/fonts

# udev gothic — pinned to v2.2.0
UDEV_GOTHIC_VERSION="v2.2.0"
UDEV_GOTHIC_SHA256="c104c171f6ed8922ca52d74cd915a271e427f1e884e51431aae71d99e8b3b47b"
mkdir -p ~/.local/share/fonts/UDEVGothic
curl -fL -o "$FONT_TMPDIR/UDEVGothic.zip" \
  "https://github.com/yuru7/udev-gothic/releases/download/${UDEV_GOTHIC_VERSION}/UDEVGothic_${UDEV_GOTHIC_VERSION}.zip"
verify_checksum "$FONT_TMPDIR/UDEVGothic.zip" "$UDEV_GOTHIC_SHA256"
(cd "$FONT_TMPDIR" && unzip -j -o UDEVGothic.zip -d ~/.local/share/fonts/UDEVGothic)

# Hack Nerd Font — pinned to v3.4.0
HACK_NERD_FONT_VERSION="v3.4.0"
HACK_NERD_FONT_SHA256="8ca33a60c791392d872b80d26c42f2bfa914a480f9eb2d7516d9f84373c36897"
mkdir -p ~/.local/share/fonts/HackNerdFont
curl -fL -o "$FONT_TMPDIR/HackNerdFont.zip" \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/${HACK_NERD_FONT_VERSION}/Hack.zip"
verify_checksum "$FONT_TMPDIR/HackNerdFont.zip" "$HACK_NERD_FONT_SHA256"
(cd "$FONT_TMPDIR" && unzip -j -o HackNerdFont.zip -d ~/.local/share/fonts/HackNerdFont)

# Fira Code — pinned to 6.2
FIRA_CODE_VERSION="6.2"
FIRA_CODE_SHA256="0949915ba8eb24d89fd93d10a7ff623f42830d7c5ffc3ecbf960e4ecad3e3e79"
mkdir -p ~/.local/share/fonts/FiraCode
curl -fL -o "$FONT_TMPDIR/FiraCode.zip" \
  "https://github.com/tonsky/FiraCode/releases/download/${FIRA_CODE_VERSION}/Fira_Code_v${FIRA_CODE_VERSION}.zip"
verify_checksum "$FONT_TMPDIR/FiraCode.zip" "$FIRA_CODE_SHA256"
(cd "$FONT_TMPDIR" && unzip -j -o FiraCode.zip -d ~/.local/share/fonts/FiraCode)

fc-cache -vf
