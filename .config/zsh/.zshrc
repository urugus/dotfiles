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
eval "$(starship init zsh)"

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
  if docker info &>/dev/null; then
    echo "Docker cleanup (7+ days old resources)..."
    docker system prune -f --filter "until=168h" 2>/dev/null
    touch "$DOCKER_PRUNE_MARKER"
  fi
fi
