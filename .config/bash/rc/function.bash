# Functions

# fzf history
fzf_history() {
  local l=$(HISTTIMEFORMAT= history | \
  sort -r | sed -E s/^\ *[0-9]+\ +// | \
  peco)
  if [ -n "$l" ]; then
    READLINE_LINE="$l" READLINE_POINT=${#l}
  fi
}

# fzf spec file & run selected rspec
fzf_rspec() {
  local selected_file=$(find . -follow -name "*_spec.rb" | grep 'spec/' | fzf)
  if [[ -n "$selected_file" ]]; then
    local command="bundle exec rspec $selected_file"
    echo "$command"
    history -s "$command"
    eval "$command"
  fi
}
