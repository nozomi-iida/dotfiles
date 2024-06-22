#!/bin/bash -e

echo "Create .config links."
for configFile in .config/*; do
  ln -snfv "$(pwd)/$configFile" "$HOME/$configFile"
done
