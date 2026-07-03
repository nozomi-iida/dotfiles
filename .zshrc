export EDITOR=vim
setopt nonomatch

export ZSH="/home/nozomi/.oh-my-zsh"
ZSH_THEME="fino-time"
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# ~/.local/bin (uv, uvx, claude, tb など)
export PATH="$PATH:/home/nozomi/.local/bin"

# mise (本体はhome-managerのprograms.miseで導入。ここで有効化する)
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# Global Path config
export PATH=$HOME/command:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$PATH:/snap/bin:$PATH

# Rust
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# Golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# ghq + peco
ghq_peco_repo() {
  selected_repository=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_repository" ]; then
    cd $selected_repository
    echo "$selected_repository"
    zle reset-prompt
  fi
}
zle -N ghq_peco_repo
bindkey '^]' ghq_peco_repo

# alias
alias vim='nvim'
alias v='nvim'
alias fig="docker compose"
# alias git='echo "Temporarily disabled git command"'

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
complete -C 'aws_completer' aws

# Add npm global packages to PATH
NPM_PREFIX=$(npm config get prefix)
export PATH=$PATH:$NPM_PREFIX/bin

# pnpm
export PNPM_HOME="/home/nozomi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# moonbit
if [ -d "$HOME/.moon" ]; then
  export PATH="$HOME/.moon/bin:$PATH"
fi

# herdr: 名前を付けていないタブはカレントパスの最後(ディレクトリ名)を表示する
# (herdr本体に自動命名の設定がないためCLIで実現。自動生成のタブ名は数字の連番
# なので、「数字のみ or 前回この仕組みで付けた名前」のときだけリネームし、
# 手動で付けた名前は上書きしない)
if [[ -n "$HERDR_TAB_ID" ]] && command -v herdr &> /dev/null && command -v jq &> /dev/null; then
  _herdr_auto_tab_name() {
    local label
    label=$(herdr tab get "$HERDR_TAB_ID" 2> /dev/null | jq -r '.result.tab.label') || return 0
    if [[ "$label" == <-> || "$label" == "$_herdr_last_auto_name" ]]; then
      _herdr_last_auto_name="${PWD:t}"
      herdr tab rename "$HERDR_TAB_ID" "$_herdr_last_auto_name" &> /dev/null
    fi
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _herdr_auto_tab_name
  _herdr_auto_tab_name
fi

# Local-only secrets / machine-specific env (see ~/.zshrc.local, not tracked in git)
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
