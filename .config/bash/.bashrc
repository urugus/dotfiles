### Environment Variables ###
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
eval "$(rbenv init -)"
eval "$(nodenv init -)"

# bash
export BA_DIR=$HOME/dotfiles/.config/bash
export BA_RC_DIR=$HOME/dotfiles/.config/bash/rc

# git editor
export GIT_EDITOR=nvim
export VISUAL=nvim
export EDITOR=nvim


### History settings ###
export HISTSIZE=10000
export HISTFILESIZE=20000
# Make history unique
HISTCONTROL=ignoredups:erasedups


### Aliases ###
source $BA_RC_DIR/alias.bash


### BindKeys ###
source $BA_RC_DIR/bindkey.bash


### Functions ###
source $BA_RC_DIR/function.bash


### Plugins ###
source $BA_RC_DIR/pluginlist.bash
