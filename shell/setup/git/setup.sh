#!/bin/bash -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
DOTFILES_DIR=$(cd "$SCRIPT_DIR/../../.." && pwd)

echo "Create .gitignore link."
ln -snfv "$(pwd)/git/.gitignore" "$HOME/.config/git/ignore"

echo "Setup .gitconfig"

read -p "Enter your git user name: " git_user_name
read -p "Enter your git user email: " git_user_email

cat > "$HOME/.gitconfig" << EOF
[user]
	name = $git_user_name
	email = $git_user_email

EOF
cat "$DOTFILES_DIR/git/.gitconfig" >> "$HOME/.gitconfig"
echo "Created $HOME/.gitconfig"
