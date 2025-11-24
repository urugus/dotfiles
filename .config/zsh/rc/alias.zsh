#===============================================================================#
##                         Aliases                                      ##
#===============================================================================#

## ls
alias ls='ls -p -G'
alias la='ls -A'
alias ll='ls -l'
alias lla='ll -A'

### docker
alias dc='docker_compose'

# Git
alias g='git_command'
alias gswb='fzf_git_switch_branch'

# Ruby on Rails
alias be='bundle_exec_command'
alias bersdif='bundle exec rspec $(git diff --name-only HEAD^ | rg "_spec\\.rb$" | peco)'
alias br='bin/rails'

# Pythhon
alias python='python3'
alias pip='pip3'

# vi
alias vi='nvim'

# AI
alias claude-bedrock='AWS_PROFILE=bedrock claude'

#===============================================================================#
##                         Global Aliases                                      ##
#===============================================================================#

alias -g G='| rg'
alias -g H='| head'
alias -g T='| tail'
