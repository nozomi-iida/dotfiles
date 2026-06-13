#!/bin/bash -e

sudo apt install zsh -y
zsh --version
# ログイン後に$SHELLがzshになる
sudo chsh -s $(which zsh)

# install oh-my-zsh
# インストール後にデフォルトshellをzshにするか聞かれるためYesを選択
# TODO: 要動作確認
RUNZSH=no CHSH=yes KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Link .zshrc."
ln -sfv "$(pwd)/.zshrc" "$HOME/.zshrc"

source ~/.zshrc
