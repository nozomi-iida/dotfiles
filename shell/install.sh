#!/bin/bash -e

echo "Create .zshrc link."
ln -snfv "$(pwd)/.zshrc" "$HOME/.zshrc"

echo "Create .config links."
for configFile in .config/*; do
  ln -snfv "$(pwd)/$configFile" "$HOME/$configFile"
done

echo "Create command links."
mkdir -p "$HOME/command"
for commandFile in command/*; do
  ln -snfv "$(pwd)/$commandFile" "$HOME/$commandFile"
done

echo "Create git links."
for gitFile in git/.??*; do
  ln -snfv "$(pwd)/$gitFile" "$HOME/$(echo $gitFile | sed -e 's/\git\///g')"
done

echo "Success"
