#==============================================================#
## Setup zinit                                                ##
#==============================================================#
if [ -z "$ZPLG_HOME" ]; then ZPLG_HOME="$ZDATADIR/zinit"
fi

if ! test -d "$ZPLG_HOME"; then
  mkdir -p "$ZPLG_HOME"
  chmod g-rwX "$ZPLG_HOME"
  # Supply-chain hardening: pin zinit to commit corresponding to v3.14.0
  git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "${ZPLG_HOME}/bin"
  (cd "${ZPLG_HOME}/bin" && git checkout --detach 412ff3b6d9c0cd9ceb4b4f17aea39dda9e1abad5)
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
# Supply-chain hardening: pin each plugin to a specific commit via ver"<hash>"
zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  ver"14c8d2e0ffaee98f2df9850b19944f32546fdea5" \
  light-mode for @zsh-users/zsh-history-substring-search

zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  ver"9bc52fed2900460fc4bef0a77c9382d6175eb63a" \
  light-mode for @zdharma/history-search-multi-word

zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  ver"598675303044df8e9d04722f3adff4f63a238922" \
  light-mode for @mollifier/anyframe
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs

#--------------------------------#
# vim mode
#--------------------------------#
# zsh-history-substring-search script path

# zinit ice lucid wait
# zinit light jeffreytse/zsh-vi-mode
# HIST_SEARCH_SCRIPT="${ZINIT_PLUGINS_DIR}/zsh-users---zsh-history-substring-search/zsh-history-substring-search.zsh"
# zvm_after_init_commands+=('[ -f ${HIST_SEARCH_SCRIPT} ] && source ${HIST_SEARCH_SCRIPT}')
# zvm_after_init_commands+=('bindkey "^P" history-substring-search-up')
# zvm_after_init_commands+=('bindkey "^N" history-substring-search-down')

#--------------------------------#
# completion
#--------------------------------#
zinit wait'0' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  ver"85919cd1ffa7d2d5412f6d3fe437ebdbeeec4fc5" \
  light-mode for @zsh-users/zsh-autosuggestions

zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  ver"adad765241061b9b63485991f268b2771524ed42" \
  light-mode for @zsh-users/zsh-completions

#--------------------------------#
# syntax highlight
# --------------------------------#
zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  ver"1d85c692615a25fe2293bdd44b34c217d5d2bf04" \
  light-mode for @zsh-users/zsh-syntax-highlighting

#--------------------------------#
# move directory
#--------------------------------#
eval "$(zoxide init zsh)"

#--------------------------------#
# gwq completion
#--------------------------------#
if command -v gwq &>/dev/null; then
  source <(gwq completion zsh)
fi
