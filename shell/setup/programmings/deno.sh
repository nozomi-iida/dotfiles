OS=$(uname)
if [ "$OS" = "Darwin" ] || [ "$OS" = "Linux" ]; then
  curl -fsSL https://deno.land/install.sh | sh
elif [ "$OS" = "Windows" ]; then
  irm https://deno.land/install.ps1 | iex
fi
