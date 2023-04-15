eval "$(starship init zsh)"

# Node
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

# ASDF
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# NVIM
alias vim="nvim"
alias pp="cd ~/personal/projects"
alias pst="mdless ~/personal/projects/projects.md"
alias dt="cd ~/dotfiles"
alias vc="cd ~/.config/nvim/lua/user"

# pnpm
export PNPM_HOME="/Users/joaogomes/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

