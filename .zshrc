# If you come from bash you might have to change your $PATH.
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
    	git
    	zsh-autosuggestions
    	zsh-syntax-highlighting
    	z
    )

source $ZSH/oh-my-zsh.sh

# ~~~~~~~~~~~~~~~ Git Prompt ~~~~~~~~~~~~~~~~~~~~~~~~ 

parse_git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    echo "($branch)"
  fi
}

setopt prompt_subst

PS1='%F{green}%n%f:%F{blue}%~%f%F{red}$(parse_git_branch)%f~ '

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# config
export BROWSER="firefox"

# directories
export REPOS="$HOME/repos"
export GITUSER="j5gomes"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SECOND_BRAIN="$HOME/second-brain"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
# alias vim=nvim

# cd
alias ..="cd .."
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
# alias la='exa -laghm@ --all --icons --git --color=always'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias sk='killall ssh-agent && source ~/.zshrc'
alias t='tmux'
alias e='exit'
alias c='code'
alias rmrf='mv'

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# ricing
alias ez='v ~/.zshrc'
alias eb='v ~/.bashrc'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sz='source ~/.zshrc'
alias sbr='source ~/.bashrc'

# vim & second brain
alias sb="cd \$SECOND_BRAIN"
alias in="cd \$SECOND_BRAIN/0-inbox/"

# fun
alias fishies=asciiquarium

# env variables
export VISUAL=nvim
export EDITOR=nvim
