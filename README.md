# Dotfiles

## Nixのセットアップ

最初にNixを入れて、CLIツール（git, neovim, tmux, ripgrep, lazygit, peco, ghq, unzip, wget など）をまとめてインストールする。
以降のセットアップは、ここで入れたCLIツールが使える前提で進める。

```bash
# Nix本体をインストール（flakes有効。これだけはシステムのcurlを使う）
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes

# CLIツールをインストール（flakeは追跡ファイルしか見ないため git add が必要）
git add nix/
nix run home-manager/master -- switch --flake ./nix#wsl
```

2回目以降（ツールの追加・更新）は以下で反映する。

```bash
home-manager switch --flake ./nix#wsl
```

## ランタイムのセットアップ（mise）

node / go / rust / deno / java / bun などの言語ランタイムは mise 一本で管理する。
設定は `.config/mise/config.toml`（dotfilesからsymlink）にまとまっている。

```bash
# 設定ファイルを信頼（symlink先パスが標準と違うため初回のみ必要）
mise trust ~/.config/mise/config.toml

# config.toml に書かれたツールを一括インストール
mise install
```

ツールの追加・バージョン変更は `.config/mise/config.toml` を編集して `mise install` で反映する。

## nvimのセットアップ

```bash
./shell/setup/nvim/setup.sh
```

## Claude Codeのセットアップ

```bash
./shell/setup/claude/setup.sh

claude mcp add --scope user --transport http notion https://mcp.notion.com/mcp
claude mcp add --scope user context7 -- npx --yes @upstash/context7-mcp
claude mcp add --scope user playwright npx @playwright/mcp@latest
# Execute the command when I want to add GitHub MCP in Project
claude mcp add --scope user --transport http github https://api.githubcopilot.com/mcp -H "Authorization: Bearer ${GITHUB_MCP_TOKEN}"
```


## VsCode, Cursorのセットアップ

```bash
./shell/install_code.sh
```
