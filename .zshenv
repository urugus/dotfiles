#--------------------------------------------------#
##             Environment Variables              ##
#--------------------------------------------------#

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
 
export ZDOTDIR=$HOME/.config/zsh
export ZHOMEDIR=$HOME/.config/zsh
export ZENVDIR=$ZDOTDIR/environment.sh
export ZRCDIR=$ZHOMEDIR/rc
export ZDATADIR=$XDG_DATA_HOME/zsh
export ZCACHEDIR=$XDG_CACHE_HOME/zsh


# Backup
export BACKUP_DIR=$HOME/backup
export AQUA_SKK_DIR=$HOME/Library/Application\ Support/AquaSKK


# editor
export EDITOR=nvim

typeset -U path PATH manpath sudo_path

# paths
path=(
  /opt/homebrew/bin
  /usr/local/bin
  $HOME/.rbenv/shims
  $HOME/.local/share/zsh/zinit/polaris/bin(N-/)
  $HOME/bin(N-/)
  $HOME/.local/bin(N-/)
  $HOME/go/bin(N-/)
  $HOME/.go/bin(N-/)
  $HOME/.cargo/bin(N-/)
  $HOME/.rustup/toolchains/*/bin(N-/)
  $HOME/.nimble/bin(N-/)
  $HOME/.yarn/bin(N-/)
  $HOME/.config/yarn/global/node_modules/.bin(N-/)
  $HOME/.deno/bin(N-/)
  $path
)

export PATH

eval "$(rbenv init -)"
setopt no_global_rcs

. "$HOME/.cargo/env"
