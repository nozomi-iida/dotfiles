#!/usr/bin/env bash
# Claude Code statusline
# stdin から渡される JSON を読んで、ディレクトリ /
# コンテキスト使用量 / サブスクリプションの使用制限の使用量を表示する。
#
# rate_limits は Claude.ai サブスクリプション利用時、かつ最初の API 応答後にのみ入る。

input=$(cat)

cwd=$(jq -r '.workspace.current_dir // .cwd // empty' <<<"$input")
ctx=$(jq -r '.context_window.used_percentage // empty' <<<"$input")

DIM=$'\033[2m'
RESET=$'\033[0m'
CYAN=$'\033[36m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'

# 使用量に応じた色。少ない=緑 / 70%以上=黄 / 90%以上=赤
color_for() {
  local pct=${1%.*}
  if [ "$pct" -ge 90 ]; then
    printf '%s' "$RED"
  elif [ "$pct" -ge 70 ]; then
    printf '%s' "$YELLOW"
  else
    printf '%s' "$GREEN"
  fi
}

# rate_limits の 1 ウィンドウを "ラベル XX% (リセット HH:MM)" に整形
limit_segment() {
  local key=$1 label=$2
  local used resets used_int reset_disp

  used=$(jq -r --arg k "$key" '.rate_limits[$k].used_percentage // empty' <<<"$input")
  [ -z "$used" ] && return

  used_int=$(printf '%.0f' "$used")

  resets=$(jq -r --arg k "$key" '.rate_limits[$k].resets_at // empty' <<<"$input")
  if [ -n "$resets" ]; then
    reset_disp=$(date -d "@${resets%.*}" '+%m/%d %H:%M' 2>/dev/null)
    # 24時間以内なら時刻だけ
    if [ -n "$reset_disp" ] && [ "$((${resets%.*} - $(date +%s)))" -lt 86400 ]; then
      reset_disp=$(date -d "@${resets%.*}" '+%H:%M' 2>/dev/null)
    fi
  fi

  printf '%s%s %s%s%%%s' "$DIM" "$label" "$(color_for "$used_int")" "$used_int" "$RESET"
  [ -n "$reset_disp" ] && printf '%s(%s)%s' "$DIM" "$reset_disp" "$RESET"
}

segments=()

[ -n "$cwd" ] && segments+=("${CYAN}$(basename "$cwd")${RESET}")

if [ -n "$ctx" ]; then
  ctx_int=$(printf '%.0f' "$ctx")
  segments+=("${DIM}ctx ${RESET}$(color_for "$ctx_int")${ctx_int}%${RESET}")
fi

five=$(limit_segment five_hour "5h")
[ -n "$five" ] && segments+=("$five")

week=$(limit_segment seven_day "7d")
[ -n "$week" ] && segments+=("$week")

# " | " 区切りで出力
out=""
for s in "${segments[@]}"; do
  [ -n "$out" ] && out+="${DIM} | ${RESET}"
  out+="$s"
done
printf '%s' "$out"
