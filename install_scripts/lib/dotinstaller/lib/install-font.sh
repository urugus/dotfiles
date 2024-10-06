#!/usr/bin/env bash

set -ue

mkdir -p ~/.local/share/fonts

# udev gothic
mkdir -p ~/.local/share/fonts/UDEVGothic
UDEV_GOTHIC_RELEASES_URL="https://api.github.com/repos/yuru7/udev-gothic/releases"
curl -sfL "${UDEV_GOTHIC_RELEASES_URL}" | jq -r '.[0].assets | .[].browser_download_url' | xargs -I{} curl -fL -o /tmp/UDEVGothic.zip "{}"
(cd /tmp && unzip -j -o UDEVGothic.zip -d ~/.local/share/fonts/UDEVGothic)

# Hack Nerd Font
mkdir -p ~/.local/share/fonts/HackNerdFont
HACK_NERD_FONT_RELEASES_URL="https://api.github.com/repos/ryanoasis/nerd-fonts/releases"
curl -sfL "${HACK_NERD_FONT_RELEASES_URL}" | jq -r '.[0].assets | .[].browser_download_url' | grep Hack.zip | xargs -I{} curl -fL -o /tmp/HackNerdFont.zip "{}"
(cd /tmp && unzip -j -o HackNerdFont.zip -d ~/.local/share/fonts/HackNerdFont)

# Fira Code
mkdir -p ~/.local/share/fonts/FiraCode
FIRA_CODE_RELEASES_URL="https://api.github.com/repos/tonsky/FiraCode/releases"
LATEST_ZIP_URL=$(curl -sfL "${FIRA_CODE_RELEASES_URL}" | jq -r '.[0].assets[] | select(.name | contains(".zip")) | .browser_download_url')
curl -fL -o /tmp/FiraCode.zip "${LATEST_ZIP_URL}"
(cd /tmp && unzip -j -o FiraCode.zip -d ~/.local/share/fonts/FiraCode)

fc-cache -vf
