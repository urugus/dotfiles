#!/bin/bash

set -ue

# install yaskkserv2
# Supply-chain hardening: pin to a specific release tag
if ! command -v yaskkserv2 >/dev/null 2>&1; then
  cargo install --git https://github.com/wachikun/yaskkserv2 --tag 0.1.7 --locked --bins
fi

# setup launch agent
# plist <string> does not expand env vars or ~, so render @HOME@ at install time
src="$HOME/dotfiles/.config/skk/launch/com.user.yaskkserv2.plist"
dest="$HOME/Library/LaunchAgents/com.user.yaskkserv2.plist"

mkdir -p "$(dirname "$dest")"
sed "s|@HOME@|$HOME|g" "$src" > "$dest"

launchctl unload "$dest" 2>/dev/null || true
launchctl load -w "$dest"
