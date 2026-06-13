#!/bin/bash -e

echo "Create .config links."
for configFile in .config/*; do
  ln -snfv "$(pwd)/$configFile" "$HOME/$configFile"
done

# install nerd font(Hack)
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
filename=Hack.zip
extension="${filename##*.}"
filename="${filename%.*}"
mkdir ${filename} && pushd ${filename}
unzip ../${filename}.${extension}
popd
mkdir -p ~/.fonts
mv ${filename} ~/.fonts/
fc-cache -fv
rm Hack.zip

lazygit_config_dir="$(lazygit -cd)"
mkdir -p "$lazygit_config_dir"
ln -snfv "$(pwd)/.config/lazygit/config.yml" "$lazygit_config_dir/config.yml"
