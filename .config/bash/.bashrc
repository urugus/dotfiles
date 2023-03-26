## Environment Variables
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
export PATH="$HOME/.yarn/bin:$PATH"
eval "$(nodenv init -)"
export BA_DIR=$HOME/dotfiles/.config/bash
export BA_RC_DIR=$HOME/dotfiles/.config/bash/rc


 ### Aliases ###
source $BA_RC_DIR/alias.bash

function _update_ps1() {
  PS1="$(powerline-shell $?)\n$ "
}

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
