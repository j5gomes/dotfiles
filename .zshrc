# If you come from bash you might have to change your $PATH.
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# config
export BROWSER="firefox"

# directories
export REPOS="$HOME/Repos"
export GITUSER="joaogomesdev"
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

# work
alias todo="nvim ~/work/todo.md"
alias tfp="nvim ~/work/tfp.md"
alias ashia="nvim ~/work/ashia.md"
alias notes="nvim ~/work/notes.md"

# env variables
export VISUAL=nvim
export EDITOR=nvim

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

export PATH="~/.config/bin:$PATH"
source /usr/local/opt/spaceship/spaceship.zsh
