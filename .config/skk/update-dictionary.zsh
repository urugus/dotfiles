#!/usr/bin/env zsh

set -euo pipefail
DICT="$HOME/.backup/skk/dictionary.yaskkserv2"
mkdir -p "${DICT:h}"

# sources.txt に列挙した順に取り込み
args=()
while read src; do
  [[ -n $src ]] && args+=("$src")
done < "${0:A:h}/sources.txt"

# ログディレクトリを作成
mkdir -p ~/.skk/logs

# 辞書作成（ログを抑制）
echo "辞書を作成しています..."
yaskkserv2_make_dictionary --utf8 --dictionary-filename "$DICT" $args > ~/.skk/logs/dictionary_make.log 2>&1

# pidファイル用のディレクトリを作成
mkdir -p ~/.skk

# サーバの pid があれば再起動
if [[ -f ~/.skk/yaskkserv2.pid ]]; then
  echo "既存のyaskkserv2プロセスを終了します..."
  kill "$(cat ~/.skk/yaskkserv2.pid)" || true
fi

# サーバー起動（ログをファイルにリダイレクト）
echo "yaskkserv2サーバーを起動しています..."
# --google-japanese-input notfound: 辞書に候補がない場合のみGoogle Japanese Input APIを使用
# --midashi-utf8: UTF-8エンコーディングを使用
yaskkserv2 "$DICT" --google-japanese-input notfound --port 1178 > ~/.skk/logs/yaskkserv2.log 2>&1 &
echo $! > ~/.skk/yaskkserv2.pid
echo "yaskkserv2サーバーが起動しました（PID: $(cat ~/.skk/yaskkserv2.pid)）"
echo "ログは ~/.skk/logs/ に保存されています"

# キャッシュを有効化
mkdir -p ~/.skk/cache
yaskkserv2 "$DICT" --midashi-utf8 --google-japanese-input notfound --google-cache-filename ~/.skk/cache/google_cache --port 1178 > ~/.skk/logs/yaskkserv2.log 2>&1 &
