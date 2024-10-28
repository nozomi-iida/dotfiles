#!/bin/bash -e

echo "Create vscode settings link."

OS=$(uname)

for codeFile in Code/User/*; do
  echo "Linking $codeFile"
  if [ "$OS" = "Darwin" ]; then
    ln -snfv "$(pwd)/$codeFile" "$HOME/Library/Application Support/$codeFile"
  elif [ "$OS" = "Linux" ]; then
    ln -snfv "$(pwd)/$codeFile" "$HOME/.config/$codeFile"
  fi
done
