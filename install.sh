#!/bin/bash

set -ue

# Add Symbolic Link
helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

link_to_homedir() {
  command echo "backup old dotfiles..."
  if [ ! -d "$HOME/.dotbackup" ];then
    command echo "$HOME/.dotbackup not found. Auto Make it"
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dotdir="$script_dir"
  local ignore_files=(".git" ".gitignore" "DS_Store" ".gitmodules")

  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.[^.]*; do
      local basefile=$(basename $f)

      for ignore in "${ignore_files[@]}"; do
        if [[ "$basefile" == "$ignore" ]]; then
          command echo "Skipping $basefile"
          continue 2
        fi
      done

      if [[ -L "$HOME/$basefile" ]]; then
        command rm -f "$HOME/$basefile"
      fi

      if [[ -e "$HOME/$basefile" ]]; then
        command mv "$HOME/$basefile" "$HOME/.dotbackup"
      fi
      command ln -snf $f $HOME
    done
  else
    command echo "same install src dest"
  fi
  command echo "completed: symbolic link"
}

brew_install_check() {
  if ! command -v brew &> /dev/null; then
    command echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    command echo "Homebrew installed."
  else
    command echo "Homebrew is already installed."
  fi
}

pip_install_check() {
  if ! command -v pip &> /dev/null; then
    command echo "pip not found. Installing via Homebrew..."
    brew install python
    command echo "pip installed."
  else
    command echo "pip is already installed."
  fi
}

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

# Check if Homebrew is installed, if not, install it automatically
brew_install_check

# Check if pip is installed, if not, install it
pip_install_check

# Proceed with symbolic linking and other configurations
link_to_homedir
git config --global include.path "~/.gitconfig_shared"
command echo -e "Install completed!!!!"

