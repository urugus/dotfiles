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
export BACKUP_DIR=$HOME/backup

# git editor
export GIT_EDITOR=nvim
export VISUAL=nvim
export EDITOR=nvim

### Functions ###
source $BA_RC_DIR/function.bash


### History settings ###
HISTSIZE=300000
HISTFILESIZE=20000
HISTTIMEFORMAT="%y/%m/%d %H:%M:%S: "
HISTIGNORE="history:pwd:ls:ls *:ll:w:top:df *"   
PROMPT_COMMAND='history -a; history -c; history -r'
# Make history unique
HISTCONTROL=ignorespace
backup_bash_history


### Aliases ###
source $BA_RC_DIR/alias.bash


### BindKeys ###
source $BA_RC_DIR/bindkey.bash


### Plugins ###
source $BA_RC_DIR/pluginlist.bash
