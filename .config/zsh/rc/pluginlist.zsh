#==============================================================#
## Setup zinit                                                ##
#==============================================================#
if [ -z "$ZPLG_HOME" ]; then ZPLG_HOME="$ZDATADIR/zinit"
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
# SKK
#--------------------------------#
zinit ice wait'0' lucid
zinit light urugus/z-skk 

# Personal dictionary path (default: ~/.skk-jisyo)
export SKK_JISYO_PATH="$HOME/backup/skk/skk-jisyo.utf8"

# System dictionary path (optional)
export SKK_SYSTEM_JISYO_PATH="$HOME/backup/skk/SKK-JISYO.L"
