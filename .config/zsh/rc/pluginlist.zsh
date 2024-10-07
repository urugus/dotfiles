#==============================================================#
## Setup zinit                                                ##
#==============================================================#
if [ -z "$ZPLG_HOME" ]; then
  ZPLG_HOME="$ZDATADIR/zinit"
fi

if ! test -d "$ZPLG_HOME"; then
  mkdir -p "$ZPLG_HOME"
  chmod g-rwX "$ZPLG_HOME"
  git clone --depth 10 https://github.com/zdharma-continuum/zinit.git ${ZPLG_HOME}/bin
fi

typeset -gAH ZPLGM
ZPLGM[HOME_DIR]="${ZPLG_HOME}"
source "$ZPLG_HOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#==============================================================#
## Plugin load                                                ##
#==============================================================#

#--------------------------------#
# history
#--------------------------------#
zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  light-mode for @zsh-users/zsh-history-substring-search

zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  light-mode for @zdharma/history-search-multi-word

zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  light-mode for @mollifier/anyframe
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs

#--------------------------------#
# completion
#--------------------------------#
zinit wait'0' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  light-mode for @zsh-users/zsh-autosuggestions

zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  light-mode for @zsh-users/zsh-completions

#--------------------------------#
# syntax highlight
# --------------------------------#
zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  light-mode for @zsh-users/zsh-syntax-highlighting

#--------------------------------#
# move directory
#--------------------------------#
eval "$(zoxide init zsh)"

#--------------------------------#
# vim mode
#--------------------------------#
zinit ice lucid wait
zinit light jeffreytse/zsh-vi-mode
zvm_after_init_commands+=('[ -f ~/.zsh-history-substring-search.zsh ] && source ~/.zsh-history-substring-search.zsh')
