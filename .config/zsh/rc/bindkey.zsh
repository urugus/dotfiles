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
bindkey '^x^b' anyframe-widget-checkout-git-branch
bindkey '^x^c' anyframe-widget-cdr
bindkey '^x^k' anyframe-widget-kill
