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


# Global Path config
export PATH=$HOME/command:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$PATH:/snap/bin:$PATH

# Golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

# Deno
export DENO_INSTALL="/home/nozomi/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

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

# source $HOME/.asdf/asdf.sh
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# bun completions
[ -s "/home/nozomi/.bun/_bun" ] && source "/home/nozomi/.bun/_bun"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

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

# Created by `pipx` on 2025-01-16 03:48:15
export PATH="$PATH:/home/nozomi/.local/bin"
. "/home/nozomi/.deno/env"