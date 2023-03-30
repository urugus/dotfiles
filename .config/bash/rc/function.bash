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

# short hand 'git'
git_command(){
  case "$1" in
        ad) git add "${@}" ;;
        br) git branch "${@}" ;;
        co) git checkout "${@}" ;;
        cm) git commit "${@}" ;;
        st) git status "${@}" ;;
        pl) git pull;;
        *)  git "$@" ;;
    esac
}

### Bash ###
# fzf history
fzf_history() {
  local l=$(HISTTIMEFORMAT= history | \
  sort -r | sed -E s/^\ *[0-9]+\ +// | \
  fzf --reverse)
  if [ -n "$l" ]; then
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
fzf_select_and_run_rspec() {
  local selected_file=$(find . -follow -name "*_spec.rb" | rg 'spec/' | fzf --reverse)
  if [[ -n "$selected_file" ]]; then
    local command="bundle exec rspec $selected_file"
    echo "$command"
    history -s "be rs $selected_file"
    eval "$command"
  fi
}

# Run rspec for all changed files
run_rspec_for_all_changed_specs() {
  local selected_files=$(git diff --name-only --diff-filter=ACMR HEAD | rg '_spec.rb')
  if [[ -n "$selected_files" ]]; then
    echo "run rspec for all changed specs"
    echo "$selected_files"
    local files="$(echo "$selected_files" | tr '\n' ' ')"
    local command="be rs $files"
    eval "$command"
  fi
}

# Select changed spec
run_selected_changed_spec(){
  local selected_file=$(git diff --name-only | rg '_spec.rb' | fzf --reverse)
  if [[ -n "$selected_file" ]]; then
    echo "bundle exec $selected_file"
    history -s "be rs $selected_file"
    eval "be rs $selected_file"
  fi
}

# short hand 'bundle exec'
bundle_exec_command(){
  case "$1" in
        rs) bundle exec rspec "${@:2}" ;;
        rb) bundle exec rubocop "${@:2}" ;;
        *)  bundle exec "$@" ;;
    esac
}

# custom rspec command
bers(){
  function run_rspec_for_git_diff(){
    if [[ "$1" ]]; then
      if [[ "$1" = "-a" ]]; then
        run_rspec_for_all_changed_specs
      else
        echo "No such option commands"
      fi
    else
      run_selected_changed_spec
    fi
  }

  if [[ "$1" ]]; then
    case "$1" in
      diff) run_rspec_for_git_diff $2 ;;
      *) echo "No such option commands" ;;
    esac
  else
    fzf_select_and_run_rspec
  fi
}
