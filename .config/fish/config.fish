set -x PATH /opt/homebrew/bin $HOME/.pyenv/shims $HOME/nodenv/shims $HOME/.cargo/bin $HOME/.rbenv/shims (ruby -e 'print Gem.user_dir')/bin $GOPATH/bin $HOME/Library/Android/sdk/platform-tools $HOME/Library/Android/sdk/emulator $PATH
set -x DENO_INSTALL /Users/YOUR_USER/.deno
set -x PATH $DENO_INSTALL/bin:$PATH

status --is-interactive; and source (nodenv init -|psub)

set fish_greeting ""
set -gx TERM xterm-256color
# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always


# keybinds
bind \cr peco_select_history # Bind for peco history to Ctrl+r
bind \co peco_select_ghq_repository # Ctrl + o


# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias brc "bin/rails console"
alias brs "bin/rails server"
alias be "bundle exec"
alias rc "rubocop"
alias rs "rspec"
alias vi nvim
command -qv neovim && alias vim neovim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH


switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
end
