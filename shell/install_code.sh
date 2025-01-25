#!/bin/bash -e

echo "Create VSCode and Cursor settings link."

OS=$(uname)

for codeFile in Code/User/*; do
  filename=$(basename "$codeFile")
  echo "Linking VSCode and Cursor: $filename"
  if [ "$OS" = "Darwin" ]; then
    ln -snfv "$(pwd)/$codeFile" "$HOME/Library/Application Support/$codeFile"
    ln -snfv "$(pwd)/$codeFile" "$HOME/Library/Application Support/Cursor/User/$filename"
  elif [ "$OS" = "Linux" ]; then
    if grep -q microsoft /proc/version; then
      # WSL環境の場合
      WINDOWS_HOME=$(wslpath "$(wslvar USERPROFILE)")
      # ln -snfv "$(pwd)/$codeFile" "$WINDOWS_HOME/AppData/Roaming/$codeFile"
      touch "$WINDOWS_HOME/AppData/Roaming/Cursor/User/$filename"
      cp -f "$(pwd)/$codeFile" "$WINDOWS_HOME/AppData/Roaming/Cursor/User/$filename"
    else
      # 通常のLinux環境の場合
      # ln -snfv "$(pwd)/$codeFile" "$HOME/.config/$codeFile"
      ln -snfv "$(pwd)/$codeFile" "$HOME/.config/Cursor/User/$filename"
    fi
  fi
done
