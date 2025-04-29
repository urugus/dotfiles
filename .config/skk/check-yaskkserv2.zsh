#!/usr/bin/env zsh

# yaskkserv2の起動状態を確認するスクリプト

# 色の定義
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo "yaskkserv2の起動状態を確認しています..."
echo "----------------------------------------"

# 1. プロセスの確認
YASKKSERV2_PROCESSES=$(ps aux | grep yaskkserv2 | grep -v grep | grep -v check-yaskkserv2)
if [[ -n "$YASKKSERV2_PROCESSES" ]]; then
  # 実際のPIDを取得（ポート1178を使用しているプロセス）
  ACTUAL_PID=$(echo "$YASKKSERV2_PROCESSES" | grep "port 1178" | awk '{print $2}')

  if [[ -n "$ACTUAL_PID" ]]; then
    echo "yaskkserv2プロセス: ${GREEN}見つかりました${NC} (実際のPID: $ACTUAL_PID)"
    echo "プロセス状態: ${GREEN}実行中${NC} (ポート1178でリッスン中)"
  else
    # ポート1178を使用していないが、yaskkserv2プロセスは存在する場合
    ACTUAL_PID=$(echo "$YASKKSERV2_PROCESSES" | head -1 | awk '{print $2}')
    echo "yaskkserv2プロセス: ${YELLOW}見つかりました${NC} (実際のPID: $ACTUAL_PID)"
    echo "プロセス状態: ${YELLOW}実行中${NC} (ただし、ポート1178ではありません)"
  fi

  echo "----------------------------------------"
  echo "$YASKKSERV2_PROCESSES"
  echo "----------------------------------------"

  # 2. PIDファイルの確認
  if [[ -f ~/.skk/yaskkserv2.pid ]]; then
    FILE_PID=$(cat ~/.skk/yaskkserv2.pid)

    if [[ "$FILE_PID" == "$ACTUAL_PID" ]]; then
      echo "PIDファイル: ${GREEN}存在します${NC} (PID: $FILE_PID - 実際のプロセスと一致)"
    else
      echo "PIDファイル: ${YELLOW}存在します${NC} (PID: $FILE_PID - 実際のプロセス $ACTUAL_PID と異なります)"
      echo "注意: PIDの不一致はyaskkserv2のデーモン化による正常な動作です"
    fi
  else
    echo "PIDファイル: ${RED}存在しません${NC}"
    echo "警告: PIDファイルがないため、次回起動時に既存のプロセスを終了できない可能性があります"
  fi
else
  echo "yaskkserv2プロセス: ${RED}見つかりません${NC}"
  echo "プロセス状態: ${RED}実行されていません${NC}"

  # PIDファイルの確認
  if [[ -f ~/.skk/yaskkserv2.pid ]]; then
    PID=$(cat ~/.skk/yaskkserv2.pid)
    echo "PIDファイル: ${YELLOW}存在します${NC} (PID: $PID - プロセスは実行されていません)"
  else
    echo "PIDファイル: ${RED}存在しません${NC}"
  fi
fi

# 3. ポートの確認
if command -v lsof > /dev/null; then
  PORT_CHECK=$(lsof -i :1178 2>/dev/null)
  if [[ -n "$PORT_CHECK" ]]; then
    echo "ポート1178: ${GREEN}リッスン中${NC}"
    echo "----------------------------------------"
    echo "$PORT_CHECK"
    echo "----------------------------------------"
  else
    echo "ポート1178: ${RED}リッスンされていません${NC}"
  fi
else
  echo "ポート1178: ${YELLOW}確認できません${NC} (lsofコマンドがインストールされていません)"
fi

# 4. ログファイルの確認
if [[ -f ~/.skk/logs/yaskkserv2.log ]]; then
  echo "ログファイル: ${GREEN}存在します${NC}"
  echo "最新のログ (最後の5行):"
  echo "----------------------------------------"
  tail -n 5 ~/.skk/logs/yaskkserv2.log
  echo "----------------------------------------"
else
  echo "ログファイル: ${RED}存在しません${NC}"
fi

echo "\n起動方法:"
echo "----------------------------------------"
echo "yaskkserv2を起動するには: ${GREEN}./.config/skk/update-dictionary.zsh${NC}"
echo "詳細なログは: ${GREEN}~/.skk/logs/yaskkserv2.log${NC}"