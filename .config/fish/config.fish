set -x PATH /opt/homebrew/bin $HOME/.pyenv/shims $HOME/nodenv/shims $HOME/.cargo/bin $HOME/.rbenv/shims (ruby -e 'print Gem.user_dir')/bin $GOPATH/bin $HOME/Library/Android/sdk/platform-tools $HOME/Library/Android/sdk/emulator $PATH
status --is-interactive; and source (nodenv init -|psub)

bind \cr peco_select_history # Bind for peco history to Ctrl+r

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias brc "bin/rails console"
alias brs "bin/rails server"

set -gx EDITOR neovide

switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
end