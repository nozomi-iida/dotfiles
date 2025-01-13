# インストールチェックとインストールを行う関数
install_if_not_exists() {
  local command_name=$1
  local install_command=$2
  
  if ! command -v "$command_name" &> /dev/null; then
      echo "Installing $command_name..."
      eval "$install_command"
  else
      echo "$command_name is already installed"
  fi
}

# 基本設定
install_if_not_exists "fcitx" "sudo apt install fcitx fcitx-mozc"
im-config -n fcitx

# change overlay shortcut key
gsettings get org.gnome.mutter overlay-key
gsettings set org.gnome.mutter overlay-key 'Alt_L'

install_if_not_exists "git" "sudo apt install git"

# setup nvim
install_if_not_exists "nvim" "sudo snap install nvim"
install_if_not_exists "xclip" "sudo apt install xclip"

# Packer
if [ ! -d "${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# Chrome
install_if_not_exists "google-chrome" "
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  sudo apt install ./google-chrome-stable_current_amd64.deb && \
  rm ./google-chrome-stable_current_amd64.deb
"

# Notion
install_if_not_exists "notion" "sudo snap install notion-snap-reborn"

# Alacritty
# コマンドコピーしただけ
https://zenn.dev/shinnopo/articles/798398b1d87f62
# pecoがエラーになったので以下で解決
https://qiita.com/qq8244353/items/02ca44aedf585f7fa296

# Peek
install_if_not_exists "peek" "
  sudo add-apt-repository ppa:peek-developers/stable
  sudo apt update
  sudo apt install peek
"

# slack
install_if_not_exists "slack" "sudo snap install slack"

# zoom
# vscode
install_if_not_exists "vscode" "
  wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  sudo apt install ./vscode.deb
  rm ./vscode.deb
"
# cursor
./cursor.sh

# tmux
sudo apt install tmux -y

# alfred
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_24.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_24.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null
sudo apt update
# エラーがでたら`sudo apt --fix-broken install`で修正した
sudo apt install albert

# docker
# https://docs.docker.com/desktop/setup/install/linux/ubuntu/
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

wget -O docker-desktop-amd64.deb "https://desktop.docker.com/linux/main/amd64/178610/docker-desktop-amd64.deb?_gl=1*swaa6k*_ga*ODEzMjgzNDAzLjE3MzY3MzY4MDQ.*_ga_XJWPQMJYHQ*MTczNjczNjgwMy4xLjEuMTczNjczNzczNS42MC4wLjA."
sudo apt install ./docker-desktop-amd64.deb -y
rm ./docker-desktop-amd64.deb

# https://docs.docker.com/desktop/setup/sign-in/#credentials-management-for-linux-users
gpg --generate-key
pass init <your_generated_gpg-id_public_key>

# awscli
install_if_not_exists "aws" "
  curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'
  sudo apt install unzip -y
  unzip awscliv2.zip
  sudo ./aws/install
  rm -rf aws awscliv2.zip
"
