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

