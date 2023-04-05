### autojump ###
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

### Brewfile ###
# if install brew-files, run 'brew  file install'
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap

  _post_brewfile_update () {
    brew file update
  }
fi

### powerline-shell ###
function _update_ps1() {
  PS1="\n$(powerline-shell $?)\n"
}
if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

