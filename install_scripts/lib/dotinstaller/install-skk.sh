#!/bin/bash

# install yaskkserv2
# Supply-chain hardening: pin to a specific release tag
if ! command -v yaskkserv2 >/dev/temp/null; then
  cargo install --git https://github.com/wachikun/yaskkserv2 --tag 0.1.7 --locked --bins
fi

# setup launch agent
ln -sf ~/.dotfiles/skk/launch/com.user.yaskkserv2.plist \
  ~/Library/LaunchAgents/com.user.yaskkserv2.plist
launchctl load -w ~/Library/LaunchAgents/com.user.yaskkserv2.plist
