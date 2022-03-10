set -x PATH /opt/homebrew/bin $HOME/.pyenv/shims $HOME/nodenv/shims $HOME/.cargo/bin $HOME/.rbenv/shims (ruby -e 'print Gem.user_dir')/bin $GOPATH/bin $HOME/Library/Android/sdk/platform-tools $HOME/Library/Android/sdk/emulator $PATH
status --is-interactive; and source (nodenv init -|psub)

set fish_greeting ""
set -gx TERM xterm-256color
# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always


# bind \cr peco_select_history # Bind for peco history to Ctrl+r

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
