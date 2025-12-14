#--------------------------------------------------#
##             Environment Variables              ##
#--------------------------------------------------#

# Locale Configuration
# Override macOS system locale (en_JP) which is not a valid POSIX locale
# This fixes "setlocale: LC_ALL: cannot change locale" errors
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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
export ZINIT_PLUGINS_DIR="${ZDATADIR}/zinit/plugins"


# Backup
export BACKUP_DIR=$HOME/backup
export AQUA_SKK_DIR=$HOME/Library/Application\ Support/AquaSKK


# editor
export EDITOR="nvim"

# AI
# export CLAUDE_CODE_USE_BEDROCK=1

typeset -U path PATH manpath sudo_path

# paths
path=(
  $HOME/.ghcup/bin(N-/)
  /opt/homebrew/bin
  /usr/local/bin
  $HOME/.rbenv/shims
  $HOME/.local/share/zsh/zinit/polaris/bin(N-/)
  $HOME/bin(N-/)
  $HOME/.local/bin(N-/)
  $HOME/go/bin(N-/)
  $HOME/.go/bin(N-/)
  $HOME/Library/Python/3.9/bin(N-/)
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
