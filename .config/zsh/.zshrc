#==============================================================#
#               .zshrc                                         #
#==============================================================#

# profile
if [ "$ZSHRC_PROFILE" != "" ]; then
  zmodload zsh/zprof && zprof > /dev/null
fi

mkdir -p "$ZDATADIR" "$ZCACHEDIR"

#--------------------------------------------------------------#
##                     Aliases                                ##
#--------------------------------------------------------------#
source-safe() { if [ -f "$1" ]; then source "$1"; fi }
source "$ZRCDIR/alias.zsh"

#--------------------------------------------------------------#
##              Base Configuration                            ##
#--------------------------------------------------------------#
source "$ZRCDIR/base.zsh"

#--------------------------------------------------------------#
##                Plugins                                     ##
#--------------------------------------------------------------#
source "$ZRCDIR/pluginlist.zsh"

#--------------------------------------------------------------#
##             Shell Prompt                                   ##
#--------------------------------------------------------------#
# Remove stale Starship hooks when this file is re-sourced.
precmd_functions=(${precmd_functions:#__starship_precmd})
preexec_functions=(${preexec_functions:#__starship_preexec})
chpwd_functions=(${chpwd_functions:#__starship_chpwd})
unfunction __starship_precmd __starship_preexec __starship_chpwd 2>/dev/null || true
unset STARSHIP_SHELL STARSHIP_SESSION_KEY STARSHIP_START_TIME
PROMPT='%F{244}%1~ %#%f '
RPROMPT=''

#--------------------------------------------------------------#
##          Key Bindings                                      ##
#--------------------------------------------------------------#
source "$ZRCDIR/bindkey.zsh"

#--------------------------------------------------------------#
##          Functions                                        ##
#--------------------------------------------------------------#
source "$ZRCDIR/function.zsh"


#--------------------------------------------------------------#
##           Before Actions                                   ## 
#--------------------------------------------------------------#
# backup history
# if [[ $- == *i* ]]; then
#   # backup skk user dictionary
#   restore_backup_all
# fi



# Added by Antigravity
export PATH="/Users/urugus/.antigravity/antigravity/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

#--------------------------------------------------------------#
##          Docker Cleanup                                    ##
#--------------------------------------------------------------#
DOCKER_PRUNE_MARKER="$HOME/.docker_last_prune"
if [[ ! -f "$DOCKER_PRUNE_MARKER" ]] || [[ $(find "$DOCKER_PRUNE_MARKER" -mtime +7 2>/dev/null) ]]; then
  {
    if docker info &>/dev/null; then
      docker system prune -f --filter "until=168h" >/dev/null 2>&1
      touch "$DOCKER_PRUNE_MARKER"
    fi
  } &!
fi

# pnpm
export PNPM_HOME="/Users/urugus/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# second-brain Codex lifecycle wrapper
if [ -x "$HOME/.codex/hooks/codex-with-sb-session.sh" ]; then
  codex() {
    "$HOME/.codex/hooks/codex-with-sb-session.sh" "$@"
  }
fi
export PATH="$HOME/.npm-global/bin:$PATH"

# Android SDK (adb / emulator / sdkmanager)
# Re-assert here because interactive plugin loading (zinit) drops the path
# entries set in .zshenv; ANDROID_HOME is exported from .zshenv.
if [ -n "$ANDROID_HOME" ]; then
  export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
fi
