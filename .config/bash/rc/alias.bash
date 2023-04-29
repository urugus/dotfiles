# Aliases

## ls
alias ls='ls -p -G'
alias la='ls -A'
alias ll='ls -l'
alias lla='ll -A'

# Git
alias g='git_command'
alias gcob='fzf_git_checkout_branch'

# Ruby on Rails
alias be='bundle_exec_command'
alias bersdif='bundle exec rspec $(git diff --name-only HEAD^ | rg _spec.rb/ | peco)'
alias br='bin/rails'

# Pythhon
alias python='python3'
alias pip='pip3'

# vi
alias vi='nvim'
