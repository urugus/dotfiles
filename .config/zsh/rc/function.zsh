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

### AWS ###

# AWS プロファイル切り替え関数
aws_profile() {
  local aws_config_file="$HOME/.aws/config"
  local current_profile=$(aws configure list | grep profile | awk '{print $2}')
  local temp_creds_file="$HOME/.aws/temp_session"

  # 現在のプロファイルを表示
  show_current_profile() {
    if [[ -z "$current_profile" || "$current_profile" == "<not" ]]; then
      echo "Current profile: default"
    else
      echo "Current profile: $current_profile"
    fi
  }

  # 利用可能なプロファイル一覧を表示
  list_profiles() {
    echo "Available profiles:"
    grep -E "^\[profile" "$aws_config_file" | sed -E 's/\[profile (.*)\]/\1/' | sort
    echo "default"
  }

  # プロファイルにMFA設定があるか確認
  has_mfa() {
    local profile=$1
    if [[ "$profile" == "default" ]]; then
      return 1
    else
      grep -A10 "^\[profile $profile\]" "$aws_config_file" | grep -q "mfa_serial"
      return $?
    fi
  }

  # MFAトークンを使用して一時的な認証情報を取得
  get_session_token() {
    local profile=$1
    local mfa_token=$2
    local mfa_serial=$(grep -A10 "^\[profile $profile\]" "$aws_config_file" | grep "mfa_serial" | sed -E 's/.*mfa_serial\s*=\s*(.*)/\1/')
    local role_arn=$(grep -A10 "^\[profile $profile\]" "$aws_config_file" | grep "role_arn" | sed -E 's/.*role_arn\s*=\s*(.*)/\1/')
    local source_profile=$(grep -A10 "^\[profile $profile\]" "$aws_config_file" | grep "source_profile" | sed -E 's/.*source_profile\s*=\s*(.*)/\1/')

    if [[ -z "$source_profile" ]]; then
      source_profile="default"
    fi

    # 一時的な認証情報を取得
    echo "Getting temporary credentials using MFA token..."

    # source_profileを一時的に設定
    local original_profile=$AWS_PROFILE
    export AWS_PROFILE=$source_profile

    # AssumeRoleを使用して一時的な認証情報を取得
    local result=$(aws sts assume-role \
      --role-arn "$role_arn" \
      --role-session-name "TemporarySession" \
      --serial-number "$mfa_serial" \
      --token-code "$mfa_token" \
      --output json 2>&1)

    local exit_code=$?

    # 元のプロファイルに戻す
    if [[ -n "$original_profile" ]]; then
      export AWS_PROFILE=$original_profile
    else
      unset AWS_PROFILE
    fi

    if [[ $exit_code -ne 0 ]]; then
      echo "Error: Failed to get temporary credentials"
      echo "$result"
      return 1
    fi

    # 一時的な認証情報を環境変数に設定
    export AWS_ACCESS_KEY_ID=$(echo "$result" | jq -r '.Credentials.AccessKeyId')
    export AWS_SECRET_ACCESS_KEY=$(echo "$result" | jq -r '.Credentials.SecretAccessKey')
    export AWS_SESSION_TOKEN=$(echo "$result" | jq -r '.Credentials.SessionToken')
    export AWS_SECURITY_TOKEN=$(echo "$result" | jq -r '.Credentials.SessionToken')

    # 認証情報の有効期限を表示
    local expiration=$(echo "$result" | jq -r '.Credentials.Expiration')
    echo "Temporary credentials obtained (Expiration: $expiration)"

    # 認証情報をファイルに保存（オプション）
    echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" > "$temp_creds_file"
    echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> "$temp_creds_file"
    echo "AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" >> "$temp_creds_file"
    echo "AWS_SECURITY_TOKEN=$AWS_SECURITY_TOKEN" >> "$temp_creds_file"
    echo "AWS_PROFILE=$profile" >> "$temp_creds_file"
    echo "EXPIRATION=$expiration" >> "$temp_creds_file"

    return 0
  }

  # プロファイルを切り替え
  switch_profile() {
    local profile=$1

    # 環境変数をクリア
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    unset AWS_SECURITY_TOKEN

    if [[ "$profile" == "default" ]]; then
      unset AWS_PROFILE
      echo "Switched to default profile"
    else
      # プロファイルが存在するか確認
      if grep -q "^\[profile $profile\]" "$aws_config_file" || [[ "$profile" == "default" ]]; then
        # MFAが必要かチェック
        if has_mfa "$profile"; then
          echo "Profile $profile requires MFA"
          echo -n "Enter MFA token code (6 digits): "
          read mfa_token

          if [[ -z "$mfa_token" ]]; then
            echo "Error: MFA token not provided"
            return 1
          fi

          # MFAトークンを使用して一時的な認証情報を取得
          if ! get_session_token "$profile" "$mfa_token"; then
            return 1
          fi

          # AWS_PROFILEも設定（一部のツールはこれを使用）
          export AWS_PROFILE="$profile"
          echo "Switched to profile $profile (MFA authenticated)"
        else
          export AWS_PROFILE="$profile"
          echo "Switched to profile $profile"
        fi
      else
        echo "Error: Profile '$profile' does not exist"
        return 1
      fi
    fi
    show_current_profile
  }

  # fzfを使用してプロファイルを選択
  select_profile_with_fzf() {
    local selected_profile=$(grep -E "^\[profile" "$aws_config_file" | sed -E 's/\[profile (.*)\]/\1/' | sort | cat <(echo "default") - | fzf --reverse --header="AWSプロファイルを選択")
    if [[ -n "$selected_profile" ]]; then
      switch_profile "$selected_profile"
    fi
  }

  # 引数に基づいて処理を分岐
  case "$1" in
    -l|list) list_profiles ;;
    -c|current) show_current_profile ;;
    -u|unset)
      unset AWS_PROFILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN
      echo "AWS credentials cleared"
      ;;
    "") select_profile_with_fzf ;;
    *) switch_profile "$1" ;;
  esac
}
