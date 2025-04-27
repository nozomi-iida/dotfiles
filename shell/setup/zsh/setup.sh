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

# execute go.sh before
wget https://github.com/peco/peco/releases/download/v0.5.11/peco_linux_amd64.tar.gz
tar -xzf peco_linux_amd64.tar.gz
sudo mv peco_linux_amd64/peco /usr/local/bin/
rm -r peco_linux_amd64
rm peco_linux_amd64.tar.gz

go install github.com/x-motemen/ghq@latest

echo "Create .zshrc link."
ln -snfv "$(pwd)/.zshrc" "$HOME/.zshrc"

source ~/.zshrc
