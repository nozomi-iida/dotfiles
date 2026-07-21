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
ln -snfv "$(pwd)/claude/commands" "$HOME/.claude/commands"
ln -snfv "$(pwd)/claude/statusline.sh" "$HOME/.claude/statusline.sh"

# 外部skill(npx skills add)の実体は claude/.agents で管理する。
# npxが生成する相対リンク(claude/skills/<name> -> ../../.agents/skills/...)は
# リポジトリroot基準で解決されるため、root .agents -> claude/.agents の
# リダイレクトを経由させ、$HOME/.agents をそこへリンクする。
ln -snfv "$(pwd)/.agents" "$HOME/.agents"

