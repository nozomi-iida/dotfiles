#!/bin/bash -e

echo "Create .config links."
for configFile in .config/*; do
  # herdrは同じディレクトリにログやソケットも書き込むため、
  # ディレクトリごとではなくconfig.tomlだけをファイル単位でリンクする
  if [ "$configFile" = ".config/herdr" ]; then
    mkdir -p "$HOME/.config/herdr"
    ln -snfv "$(pwd)/.config/herdr/config.toml" "$HOME/.config/herdr/config.toml"
    continue
  fi
  ln -snfv "$(pwd)/$configFile" "$HOME/$configFile"
done
