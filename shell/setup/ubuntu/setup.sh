sudo apt install fcitx fcitx-mozc
im-config -n fcitx

# change overlay shortcut key
gsettings get org.gnome.mutter overlay-key
gsettings set org.gnome.mutter overlay-key 'Alt_L'

sudo apt install git

# setup nvim
sudo snap install nvim
sudo apt install xclip
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install applications
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

sudo snap install notion-snap-reborn

# Alacritty
# コマンドコピーしただけ
https://zenn.dev/shinnopo/articles/798398b1d87f62
# pecoがエラーになったので以下で解決
https://qiita.com/qq8244353/items/02ca44aedf585f7fa296
# Peek
# slack
sudo snap install slack
# zoom
# vscode
# cursor
# tmux
sudo apt install tmux -y

# alfred
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_24.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_24.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null
sudo apt update
sudo apt install albert# docker
# エラーがでたら`sudo apt --fix-broken install`で修正した
