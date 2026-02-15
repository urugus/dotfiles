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
        wt) git worktree "${@:2}" ;;
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

### Git Worktree ###

# worktreeパス一覧を取得（ヘルパー関数）
_gwt_list_paths() {
  git worktree list | awk '{print $1}'
}

# worktree選択 + Docker起動
gwd() {
  local selected=$(_gwt_list_paths | fzf --preview 'git -C {} log --oneline -5')
  if [[ -n "$selected" ]]; then
    cd "$selected"
    if [[ -f "docker-compose.yml" ]] || [[ -f "compose.yml" ]]; then
      # .envrcがあればポート情報を表示
      if [[ -f ".envrc" ]]; then
        direnv allow 2>/dev/null
        eval "$(direnv export zsh 2>/dev/null)"
        echo "App Port: ${APP_HOST_PORT:-3000} -> 3000"
        echo "DB Port:  ${DB_HOST_PORT:-5432} -> 5432"
      fi
      echo "Starting docker compose up app..."
      docker compose up app -d
      echo "Access: http://localhost:${APP_HOST_PORT:-3000}"
    fi
  fi
}

# 稼働中のworktree環境を一覧表示
gwps() {
  _gwt_list_paths | while read -r dir; do
    local compose_file=""
    if [[ -f "$dir/docker-compose.yml" ]]; then
      compose_file="$dir/docker-compose.yml"
    elif [[ -f "$dir/compose.yml" ]]; then
      compose_file="$dir/compose.yml"
    fi
    if [[ -n "$compose_file" ]] && docker compose -f "$compose_file" ps --quiet 2>/dev/null | grep -q .; then
      local port=$(docker compose -f "$compose_file" port app 3000 2>/dev/null | cut -d: -f2)
      local branch=$(git -C "$dir" branch --show-current 2>/dev/null)
      echo "$branch → localhost:${port:-?} ($dir)"
    fi
  done
}

# マージ済みworktreeを削除
gwclean() {
  local base_branch="${1:-develop}"
  _gwt_list_paths | while read -r dir; do
    local branch=$(git -C "$dir" branch --show-current 2>/dev/null)
    # メインworktreeはスキップ
    if [[ "$branch" == "$base_branch" ]] || [[ "$branch" == "master" ]] || [[ "$branch" == "main" ]]; then
      continue
    fi
    # マージ済みかチェック
    if git branch --merged "$base_branch" 2>/dev/null | grep -q "$branch"; then
      echo "Removing worktree for $branch ($dir)..."
      # Docker停止
      if [[ -f "$dir/docker-compose.yml" ]] || [[ -f "$dir/compose.yml" ]]; then
        docker compose -f "$dir/docker-compose.yml" down -v 2>/dev/null || \
        docker compose -f "$dir/compose.yml" down -v 2>/dev/null
      fi
      git worktree remove "$dir" 2>/dev/null
    fi
  done
}

### Git Worktree Slot ###
# スロットベースのworktree管理
# 固定名ディレクトリでDocker volumeを再利用し、ブランチ切り替えを高速化

_gwslot_basedir() {
  local basedir
  basedir=$(gwq config get worktree.basedir 2>/dev/null)
  if [[ -n "$basedir" ]]; then
    echo "${basedir/#\~/$HOME}"
  else
    local main_repo
    main_repo=$(git worktree list | head -1 | awk '{print $1}')
    echo "$(dirname "$main_repo")/wt-$(basename "$main_repo")"
  fi
}

_gwslot_main_repo() {
  git worktree list | head -1 | awk '{print $1}'
}

gwslot() {
  case "${1:-list}" in
    setup)      _gwslot_setup "${@:2}" ;;
    switch|sw)  _gwslot_switch "${@:2}" ;;
    list|ls)    _gwslot_list ;;
    cd)         _gwslot_cd "${@:2}" ;;
    prune)      _gwslot_prune ;;
    help|-h|--help)
      echo "Usage: gwslot <command>"
      echo ""
      echo "Commands:"
      echo "  setup [count]              Create slot worktrees (default: 3)"
      echo "  list                       Show all slots and status (default)"
      echo "  switch <slot> <branch>     Switch slot to a different branch"
      echo "  switch <slot> -c <branch>  Switch slot to a new branch"
      echo "  cd [slot]                  Enter a slot directory (fzf if omitted)"
      echo "  prune                      Remove orphaned Docker volumes"
      ;;
    *) echo "Unknown command: $1 (see gwslot help)"; return 1 ;;
  esac
}

_gwslot_setup() {
  local count="${1:-3}"
  local basedir=$(_gwslot_basedir)
  local main_repo=$(_gwslot_main_repo)

  mkdir -p "$basedir"

  for i in $(seq 1 "$count"); do
    local slot_dir="$basedir/slot-$i"
    if [[ -d "$slot_dir" ]]; then
      echo "slot-$i: already exists ($(git -C "$slot_dir" branch --show-current 2>/dev/null))"
      continue
    fi
    echo "Creating slot-$i..."
    git -C "$main_repo" worktree add "$slot_dir" develop 2>/dev/null || \
      git -C "$main_repo" worktree add --detach "$slot_dir"
    if [[ -f "$main_repo/.envrc" ]]; then
      cp "$main_repo/.envrc" "$slot_dir/"
      (cd "$slot_dir" && direnv allow 2>/dev/null)
    fi
    echo "slot-$i: created"
  done
}

_gwslot_list() {
  local basedir=$(_gwslot_basedir)
  local found=false

  for slot_dir in "$basedir"/slot-*(N); do
    found=true
    local slot_name=$(basename "$slot_dir")
    local branch=$(git -C "$slot_dir" branch --show-current 2>/dev/null || echo "detached")
    local docker_status="stopped"
    local compose_file="$slot_dir/docker-compose.yml"
    [[ -f "$compose_file" ]] || compose_file="$slot_dir/compose.yml"

    if [[ -f "$compose_file" ]] && docker compose -f "$compose_file" ps --quiet 2>/dev/null | grep -q .; then
      local port=$(docker compose -f "$compose_file" port app 3000 2>/dev/null | cut -d: -f2)
      docker_status="\033[32mrunning → localhost:${port:-?}\033[0m"
    else
      docker_status="\033[90mstopped\033[0m"
    fi

    echo -e "$slot_name\t$branch\t$docker_status"
  done | column -t -s $'\t'

  if ! $found; then
    echo "No slots found. Run 'gwslot setup' to create slots."
  fi
}

_gwslot_switch() {
  local slot_name="$1"
  local create_flag=""
  local target_branch=""

  if [[ -z "$slot_name" ]]; then
    echo "Usage: gwslot switch <slot> <branch>"
    echo "       gwslot switch <slot> -c <branch>"
    return 1
  fi

  shift
  if [[ "$1" == "-c" ]]; then
    create_flag="-c"
    shift
  fi
  target_branch="$1"

  if [[ -z "$target_branch" ]]; then
    echo "Usage: gwslot switch <slot> [-c] <branch>"
    return 1
  fi

  local basedir=$(_gwslot_basedir)
  local slot_dir="$basedir/$slot_name"

  if [[ ! -d "$slot_dir" ]]; then
    echo "Error: $slot_name does not exist. Run 'gwslot setup' first."
    return 1
  fi

  local current_branch=$(git -C "$slot_dir" branch --show-current 2>/dev/null)
  echo "$slot_name: $current_branch → $target_branch"

  # Docker停止（volumeは保持）
  local compose_file="$slot_dir/docker-compose.yml"
  [[ -f "$compose_file" ]] || compose_file="$slot_dir/compose.yml"
  if [[ -f "$compose_file" ]] && docker compose -f "$compose_file" ps --quiet 2>/dev/null | grep -q .; then
    echo "Stopping Docker containers..."
    docker compose -f "$compose_file" stop
  fi

  # ブランチ切り替え
  if [[ -n "$create_flag" ]]; then
    git -C "$slot_dir" switch -c "$target_branch" || return 1
  else
    git -C "$slot_dir" checkout "$target_branch" || return 1
  fi

  # cdしてDocker起動
  cd "$slot_dir"
  if [[ -f ".envrc" ]]; then
    direnv allow 2>/dev/null
    eval "$(direnv export zsh 2>/dev/null)"
  fi

  echo "Starting Docker containers..."
  docker compose up app -d
  echo "Access: http://localhost:${APP_HOST_PORT:-3000}"
}

_gwslot_cd() {
  local basedir=$(_gwslot_basedir)
  local slot_name="$1"

  if [[ -z "$slot_name" ]]; then
    slot_name=$(ls -d "$basedir"/slot-* 2>/dev/null | while read -r d; do
      local name=$(basename "$d")
      local branch=$(git -C "$d" branch --show-current 2>/dev/null)
      echo "$name ($branch)"
    done | fzf --preview "git -C $basedir/\$(echo {} | cut -d' ' -f1) log --oneline -5 2>/dev/null" | cut -d' ' -f1)
  fi

  [[ -z "$slot_name" ]] && return 1

  local slot_dir="$basedir/$slot_name"
  if [[ ! -d "$slot_dir" ]]; then
    echo "Error: $slot_name does not exist"
    return 1
  fi

  cd "$slot_dir"
  echo "Branch: $(git branch --show-current 2>/dev/null)"
  if [[ -f ".envrc" ]]; then
    direnv allow 2>/dev/null
    eval "$(direnv export zsh 2>/dev/null)"
    echo "App Port: ${APP_HOST_PORT:-3000}"
  fi
}

_gwslot_prune() {
  # アクティブなworktreeのCOMPOSE_PROJECT_NAMEを収集
  local -a active_projects
  while read -r dir; do
    if [[ -f "$dir/.envrc" ]]; then
      local proj
      proj=$(cd "$dir" && eval "$(direnv export bash 2>/dev/null)" && echo "$COMPOSE_PROJECT_NAME")
      [[ -n "$proj" ]] && active_projects+=("$proj")
    fi
  done < <(git worktree list | awk '{print $1}')

  # メインリポジトリのCOMPOSE_PROJECT_NAMEも追加
  local main_proj="$COMPOSE_PROJECT_NAME"
  [[ -n "$main_proj" ]] && active_projects+=("$main_proj")

  local -a orphans
  while read -r vol; do
    local is_active=false
    for proj in "${active_projects[@]}"; do
      if [[ "$vol" == "${proj}_"* ]]; then
        is_active=true
        break
      fi
    done
    $is_active || orphans+=("$vol")
  done < <(docker volume ls --format '{{.Name}}' | grep '^dw_worker_')

  if [[ ${#orphans[@]} -eq 0 ]]; then
    echo "No orphaned volumes found."
    return 0
  fi

  echo "Orphaned Docker volumes:"
  for vol in "${orphans[@]}"; do
    echo "  $vol"
  done

  echo ""
  echo -n "Remove ${#orphans[@]} orphaned volumes? [y/N]: "
  read answer
  if [[ "$answer" == [yY] ]]; then
    for vol in "${orphans[@]}"; do
      docker volume rm "$vol" && echo "  removed: $vol"
    done
  fi
}

### AWS ###

# AWS プロファイル切り替え関数
aws_switch_profile() {
  local selected_profile
  selected_profile=$(grep '\[profile' ~/.aws/config | sed 's/.*profile \(.*\)\]/\1/' | fzf --prompt="AWS Profile> ")
  
  if [[ -z "$selected_profile" ]]; then
    echo "No profile selected."
    return 1
  fi

  local role_arn source_profile mfa_serial
  role_arn=$(aws configure get role_arn --profile "$selected_profile")
  source_profile=$(aws configure get source_profile --profile "$selected_profile")
  mfa_serial=$(aws configure get mfa_serial --profile "$selected_profile")

  if [[ -z "$role_arn" || -z "$source_profile" ]]; then
    echo "No AssumeRole configuration found. Setting profile directly."
    export AWS_PROFILE="$selected_profile"
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    echo "Switched to AWS_PROFILE=$AWS_PROFILE"
    return
  fi

  local creds
  if [[ -n "$mfa_serial" ]]; then
    echo -n "Enter MFA code: "
    read mfa_code
    creds=$(aws sts assume-role --profile "$source_profile" --role-arn "$role_arn" \
      --role-session-name "zsh-session-$(date +%s)" \
      --serial-number "$mfa_serial" --token-code "$mfa_code")
  else
    creds=$(aws sts assume-role --profile "$source_profile" --role-arn "$role_arn" \
      --role-session-name "zsh-session-$(date +%s)")
  fi

  if [[ $? -ne 0 ]]; then
    echo "Failed to assume role."
    return 1
  fi

  local aws_access_key_id aws_secret_access_key aws_session_token aws_region

  aws_access_key_id=$(echo "$creds" | jq -r '.Credentials.AccessKeyId')
  aws_secret_access_key=$(echo "$creds" | jq -r '.Credentials.SecretAccessKey')
  aws_session_token=$(echo "$creds" | jq -r '.Credentials.SessionToken')
  aws_region=$(aws configure get region --profile "$selected_profile")

  export AWS_ACCESS_KEY_ID=$aws_access_key_id
  export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
  export AWS_SESSION_TOKEN=$aws_session_token
  export AWS_REGION=$aws_region

  unset AWS_PROFILE
  echo "Switched to AWS profile '$selected_profile'."
}
