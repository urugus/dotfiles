# Functions

### Git ###
# short hand 'git'
git_command(){
  case "$1" in
        ad) git add "${@:2}" ;;
        br) git branch "${@:2}" ;;
        cm) git commit "${@:2}" ;;
        co) git checkout "${@:2}" ;;
        pl) git pull;;
        pr) gh pr create -a @me -w ;;
        ps) git push "${@:2}" ;;
        rb) git rebase "${@:2}" ;;
        ri) git rebase -i HEAD~"${@:2}" ;;
        st) git status "${@:2}" ;;
        sw) git switch "${@:2}" ;;
        swc) git switch -c "${@:2}" ;;
        *)  git "$@" ;;
    esac
}

# select & switch git brahch
fzf_git_switch_branch() {
  local selected_branch=$(git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)' | awk '{print $1, $2}' | fzf --reverse | awk '{print $2}')
  if [[ -n "$selected_branch" ]]; then
    local command="git switch $selected_branch"
    eval "$command"
  fi
}

### Backup ###

# backup skk user dictionary
restore_backup_all() {
# check backup_dir existence
if [ ! -d "$BACKUP_DIR" ]; then
  echo "Error: $BACKUP_DIR does not exist."
  return 1
fi

cd "$BACKUP_DIR" >/dev/null || return 1

git add -A
# Commit if there are changes
if [ -n "$(git status --porcelain)" ]; then
  git commit -q -m "auto backup: skk dictionary"
  git push || { echo "Error: Failed to push changes."; return 1; }
fi

# Attempt to pull with rebase
if ! git pull --rebase; then
  echo "Conflict detected. Attempting to resolve conflicts..."

  # Mark all conflicts as resolved by using 'theirs' strategy
  git merge --strategy-option=theirs || {
    echo "Error: Merge failed. Please resolve manually."
    cd - >/dev/null || return
    return 1
  }

  # Commit the resolved changes
  git commit -q -m "auto resolved merge conflict: skk dictionary"
  git push || { echo "Error: Failed to push resolved changes."; return 1; }
fi

cd - >/dev/null || return
}

### Rails Development ###

# short hand 'docker-compose exec'
docker_compose(){
  case "$1" in
        up) docker-compose up "${@:2}" ;;
        cs) docker compose exec app bundle exec rails c ;;
        rs) docker-compose exec rspec bundle exec rspec "${@:2}" ;;
        rc) docker-compose exec rspec bundle exec rubocop -a "${@:2}" ;;
        rr) docker-compose exec rspec bundle exec rspec "${@:2}" && docker-compose exec rspec bundle exec rubocop -a "${@:2}" ;;
        *)  docker-compose "$@" ;;
    esac
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

