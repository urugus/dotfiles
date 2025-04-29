#!/bin/bash

# install yaskkserv2
if ! command -v yaskkserv2 >/dev/temp/null; then
  cargo install --git https://github.com/wachikun/yaskkserv2 --locked --bins
fi

# setup launch agent
ln -sf ~/.dotfiles/skk/launch/com.user.yaskkserv2.plist \
  ~/Library/LaunchAgents/com.user.yaskkserv2.plist
launchctl load -w ~/Library/LaunchAgents/com.user.yaskkserv2.plist
