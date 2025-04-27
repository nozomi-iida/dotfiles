#!/bin/bash -e

echo "Create .config links."
for configFile in .config/*; do
  ln -snfv "$(pwd)/$configFile" "$HOME/$configFile"
done

sudo apt install tmux -y
sudo snap install nvim --classic
sudo apt install xclip

# Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
./shell/setup/programmings/node.sh
# TODO: 要動作確認
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall'



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

# install ripgrepg to use telescope.live_grep
sudo apt install ripgrep -y
