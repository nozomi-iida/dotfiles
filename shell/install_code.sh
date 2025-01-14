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
    ln -snfv "$(pwd)/$codeFile" "$HOME/.config/$codeFile"
    ln -snfv "$(pwd)/$codeFile" "$HOME/.config/Cursor/User/$filename"
  fi
done
