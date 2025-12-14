#==============================================================#
##          Key Bindings                                      ##
#==============================================================## Bind keys

# Disable vi-mode and use emacs mode
bindkey -e

## move ##
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line


## history ##
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
bindkey '^x^b' fzf_git_switch_branch
bindkey '^x^c' anyframe-widget-cdr
bindkey '^x^k' anyframe-widget-kill

## Claude ##
function _claude-widget() { 
  # Clear the current line and run claude
  BUFFER=""
  zle accept-line
  claude
}
zle -N _claude-widget
bindkey '^o' _claude-widget

## Git ##
function _lazygit-widget() { lazygit }
zle -N _lazygit-widget
bindkey '^\\' _lazygit-widget

## Filer ##
function _yazi-widget() { yazi }
zle -N _yazi-widget
bindkey '^f' _yazi-widget

## Completion ##
zle -N zi
bindkey '^z' zi

## zsh-skk ##
# Ctrl+J to toggle Japanese input mode
# Check if z-skk is loaded before setting up keybindings
if (( ${+functions[z-skk-setup-keybindings]} )); then
    z-skk-setup-keybindings
fi
# The actual binding will be set up by z-skk when it loads
