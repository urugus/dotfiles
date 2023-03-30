# Aliases

## ls
alias ls='ls -p -G'
alias la='ls -A'
alias ll='ls -l'
alias lla='ll -A'

# Git
alias g='git'
alias gad='git add'
alias gada='git add .'
alias gcm='git commit'
alias gco='fzf_git_checkout_branch'
alias gcoa='git checkout .'
alias gcob='git checkout -b'
alias gps='git push'
alias gpl='git pull'
alias gst='git status'

# Ruby on Rails
alias be='bundle exec'
alias bers='fzf_select_rspec'
alias bersall='bundle exec rspec'
alias bersdif='bundle exec rspec $(git diff --name-only HEAD^ | rg _spec.rb/ | peco)'
alias br='bin/rails'
alias brc='bin/rails console'
alias brs='bin/rails server'

# vi
alias vi='nvim'
