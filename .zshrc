# User configuration
export EDITOR='nvim'

# Starship
eval "$(starship init zsh)"

# Node
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# ASDF
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Alias
alias vim="nvim"
alias pp="cd ~/personal/projects"
alias pst="mdless ~/personal/projects/projects.md"
alias dotf="cd ~/dotfiles"
alias vconf="cd ~/.config/nvim/lua/user"

alias rvw="gh repo view -w"

# pnpm
export PNPM_HOME="/Users/joaogomes/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

### Zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma-continuum/history-search-multi-word
# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
# Snippet
zinit snippet https://gist.githubusercontent.com/hightemp/5071909/raw/
## end zinit
