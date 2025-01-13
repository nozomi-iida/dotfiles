install_tool() {
  local tool=$1
  local install_cmd=$2
  if ! command -v "$tool" &> /dev/null; then
    echo "Installing $tool..."
    eval "$install_cmd"
  else
    echo "$tool is already installed."
  fi
}

install_tool "volta" "curl https://get.volta.sh | bash"

install_tool "node" "volta install node"
install_tool "pnpm" "volta install pnpm"

install_tool "bun" "curl -fsSL https://bun.sh/install | bash"
