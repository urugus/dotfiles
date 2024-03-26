#==============================================================#
##          Base Configuration                                ##
#==============================================================#

# History
HOSTNAME="$HOST"
HISTFILE="${ZDATADIR}/zsh_history"
HISTSIZE=10000                    # Number of histories in memory
SAVEHIST=100000                   # Number of histories to be saved
HISTTIMEFORMAT="%y/%m/%d %H:%M:%S: "
HISTORY_IGNORE="(ls|cd|pwd|zsh|exit|cd ..)"
LISTMAX=1000                      # number of completion listings to ask for (1=shut up, 0=ask when window overflows)
setopt hist_ignore_dups           # ignore duplication command history
setopt hist_ignore_space          # ignore duplication command history
setopt hist_verify                # verify history before execution
setopt hist_ignore_all_dups       # ignore duplication command history
setopt hist_no_store              # do not store command history
setopt hist_reduce_blanks         # remove leading and trailing blanks from each history line
setopt hist_expand                # expand history in line
setopt share_history              # share command history data

# Others
setopt no_beep

