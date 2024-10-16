#!/bin/bash

function print_default() {
  echo -e "$*"
}

function print_info() {
  echo -e "\e[1;36m$*\e[m" # cyan
}

function print_notice() {
  echo -e "\e[1;35m$*\e[m" # magenta
}

function print_success() {
  echo -e "\e[1;32m$*\e[m" # green
}

function print_warning() {
  echo -e "\e[1;33m$*\e[m" # yellow
}

function print_error() {
  echo -e "\e[1;31m$*\e[m" # red
}

function print_debug() {
  echo -e "\e[1;34m$*\e[m" # blue
}

function chkcmd() {
if ! builtin command -v "$1"; then
  print_error "${1} command not found"
  exit
fi
}

function yes_or_no_select() {
local answer
print_notice "Are you ready? [yes/no]"
read -r answer
case $answer in
  yes | y)
    return 0
    ;;
  no | n)
    return 1
    ;;
  *)
    yes_or_no_select
    ;;
esac
}
