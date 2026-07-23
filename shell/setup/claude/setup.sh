#!/bin/bash -e

echo "Create .claude link."
mkdir -p "$HOME/.claude"

if [[ "$OSTYPE" == "darwin"* ]]; then
  SOURCE="settings-mac.json"
elif grep -qi microsoft /proc/version 2>/dev/null; then
  SOURCE="settings-wsl.json"
else
  SOURCE="settings-linux.json"
fi

ln -snfv "$(pwd)/claude/$SOURCE" "$HOME/.claude/settings.json"
ln -snfv "$(pwd)/claude/skills" "$HOME/.claude/skills"
ln -snfv "$(pwd)/claude/statusline.ts" "$HOME/.claude/statusline.ts"
# 旧bash版のリンクが残っていると混乱するので消す。
# `-e` 下なので `[ -L ... ] &&` だとリンクが無いときに終了してしまうため rm -f を直接使う
rm -f "$HOME/.claude/statusline.sh"

# commands はディレクトリごとではなく *.md 単位でリンクする。
# 他リポジトリ(asuene-dev-pipeline の install.sh など)も同じ
# ~/.claude/commands へファイル単位でリンクを張るため、
# ディレクトリごと張ると互いに上書きしてしまう。
[ -L "$HOME/.claude/commands" ] && rm -f "$HOME/.claude/commands"
mkdir -p "$HOME/.claude/commands"
for f in "$(pwd)"/claude/commands/*.md; do
  ln -snfv "$f" "$HOME/.claude/commands/$(basename "$f")"
done

# 外部skill(npx skills add)の実体は claude/.agents で管理する。
# npxが生成する相対リンク(claude/skills/<name> -> ../../.agents/skills/...)は
# リポジトリroot基準で解決されるため、root .agents -> claude/.agents の
# リダイレクトを経由させ、$HOME/.agents をそこへリンクする。
ln -snfv "$(pwd)/.agents" "$HOME/.agents"

