#==============================================================#
##          Key Bindings                                      ##
#==============================================================## Bind keys

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
bindkey '^x^k' anyframe-widget-killfzf_git_switch_branch

## Git ##
function _lazygit-widget() { lazygit }
zle -N _lazygit-widget
bindkey '^g' _lazygit-widget

## Filer ##
function _yazi-widget() { yazi }
zle -N _yazi-widget
bindkey '^f' _yazi-widget

## Completion ##
zle -N zi
bindkey '^z' zi
