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

# terminal
# zeek
# slack
# zoom
# vscode
# tmux
