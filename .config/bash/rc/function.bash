# Functions

### Git ###
# selecte & checkout git brahch
fzf_git_checkout_branch() {
  local selected_branch=$(git branch | sed -r "s/^[ \*]+//" | fzf --reverse)
  if [[ -n "$selected_branch" ]]; then
    local command="git checkout $selected_branch"
    eval "$command"
  fi
}


### Bash ###
# fzf history
fzf_history() {
  local l=$(HISTTIMEFORMAT= history | \
  sort -r | sed -E s/^\ *[0-9]+\ +// | \
  fzf --reverse)
  if [ -n "$l" ]; then
    history -s "$l"
    READLINE_LINE="$l" READLINE_POINT=${#l}
  fi
}

# fzf directory
fzf_directory() {
  local dir=$(find . -follow | fzf --reverse)
  if [ -n "$dir" ]; then
    READLINE_LINE="${READLINE_LINE} $dir"
    READLINE_POINT=${#READLINE_LINE}
  fi
}


### Rails ###
# fzf spec file & run selected rspec
fzf_select_rspec() {
  local selected_file=$(find . -follow -name "*_spec.rb" | grep 'spec/' | fzf --reverse)
  if [[ -n "$selected_file" ]]; then
    local command="bundle exec rspec $selected_file"
    echo "$command"
    history -s "$command"
    eval "$command"
  fi
}
