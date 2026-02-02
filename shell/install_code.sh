#!/bin/bash -e

echo "Create VSCode settings link."

OS=$(uname)

for codeFile in Code/User/*; do
  filename=$(basename "$codeFile")
  echo "Linking VSCode: $filename"
  if [ "$OS" = "Darwin" ]; then
    ln -snfv "$(pwd)/$codeFile" "$HOME/Library/Application Support/$codeFile"
  elif [ "$OS" = "Linux" ]; then
    if grep -q microsoft /proc/version; then
      # WSL環境の場合
      sudo apt install wslu
      WINDOWS_HOME=$(wslpath "$(wslvar USERPROFILE)")
      touch "$WINDOWS_HOME/AppData/Roaming/$codeFile"
      # シンボリックリンクだとうまく動かないため、ファイルをコピー
      cp -f "$(pwd)/$codeFile" "$WINDOWS_HOME/AppData/Roaming/$codeFile"
    else
      ln -snfv "$(pwd)/$codeFile" "$HOME/.config/$codeFile"
    fi
  fi
done
