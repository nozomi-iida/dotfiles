#!/bin/bash -e

echo "Create .claude link."
mkdir -p "$HOME/.claude"

if [[ "$OSTYPE" == "darwin"* ]]; then
  SOURCE="settings-mac.json"
else
  SOURCE="settings-wsl.json"
fi

ln -snfv "$(pwd)/claude/$SOURCE" "$HOME/.claude/settings.json"
ln -snfv "$(pwd)/claude/skills" "$HOME/.claude/skills"

