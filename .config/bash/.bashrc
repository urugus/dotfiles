### Environment Variables ###
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.nodenv/shims:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi
eval "$(rbenv init -)"
eval "$(nodenv init -)"

# bash
export BA_DIR=$HOME/dotfiles/.config/bash
export BA_RC_DIR=$HOME/dotfiles/.config/bash/rc
export BACKUP_DIR=$HOME/backup

# SKK 
export AQUA_SKK_DIR=$HOME/Library/Application\ Support/AquaSKK

# Variables
# only ~/.bashrc or ~/.bash_profile
if [[ $- == *i* ]]; then
  export CURRENT_BRANCH=$(git branch --show-current)
fi

# git editor
export GIT_EDITOR=nvim
export VISUAL=nvim
export EDITOR=nvim

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk

# Obsidian
export VAULT="/Users/urugus/.local/share/nvim/zettelkasten"

### Functions ###
source $BA_RC_DIR/function.bash


### History settings ###
if [[ $- == *i* ]]; then
  # backup bash history
  HISTSIZE=300000
  HISTFILESIZE=20000
  HISTTIMEFORMAT="%y/%m/%d %H:%M:%S: "
  PROMPT_COMMAND='history -a; history -c; history -r'
  # Make history unique
  HISTCONTROL=ignorespace:ignoredups
  HISTIGNORE=ls:cd:ll:lla:pwd:vi
  backup_bash_history

  # backup skk user dictionary
  backup_skk_dictionary
fi


### Aliases ###
source $BA_RC_DIR/alias.bash


### BindKeys ###
source $BA_RC_DIR/bindkey.bash


### Plugins ###
source $BA_RC_DIR/pluginlist.bash

if [ -f "/google/devshell/bashrc.google" ]; then
  source "/google/devshell/bashrc.google"
fi
