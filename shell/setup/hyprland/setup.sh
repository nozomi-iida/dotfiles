#!/bin/bash -e

echo "Create hyprland config links."
for configDir in hyprland/*; do
  ln -snfv "$(pwd)/$configDir" "$HOME/.config/$(basename "$configDir")"
done
