## Environment Variables
export PATH="$HOME/.rbenv/bin:$PATH"
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

### Plugins ###
source $BA_RC_DIR/pluginlist.bash
