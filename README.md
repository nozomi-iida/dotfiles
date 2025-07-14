# Dotfiles

## zshのセットアップ


```bash
./shell/setup/programmings/go/setup.sh
./shell/setup/zsh/setup.sh
```

## nvimのセットアップ

```bash
./shell/setup/programmings/node/setup.sh
./shell/setup/nvim/setup.sh
```

## Claude Codeのセットアップ

```bash
./shell/setup/claude/setup.sh

claude mcp add --scope user --transport http notion https://mcp.notion.com/mcp
claude mcp add --scope user context7 -- npx --yes @upstash/context7-mcp
claude mcp add --scope user playwright npx @playwright/mcp@latest
# Execute the command when I want to add GitHub MCP in Project
claude mcp add --transport http github https://api.githubcopilot.com/mcp -H ${GITHUB_MCP_TOKEN}
```


## VsCode, Cursorのセットアップ

```bash
./shell/install_code.sh
```
