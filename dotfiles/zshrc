# Path to your oh-my-zsh installation.
export ZSH=/home/phil/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="spaceship"
ZSH_THEME="geometry/geometry"

# Report exit codes so I can see if my last thing failed
SPACESHIP_EXIT_CODE_SHOW="true"
SPACESHIP_EXIT_CODE_SYMBOL="X"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-256color alias-tips)

source $ZSH/oh-my-zsh.sh

# User configuration
# Preferred editor for local and remote sessions
export EDITOR='vim'

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# Regular aliases
alias v='vim'
alias cls='clear'
alias agi='apt-get install'
alias sudo='sudo '
alias here='(nautilus --browser . &) > /dev/null 2>&1'
eval $(thefuck --alias dammit)
alias logout='sudo pkill -u ${USER}'

# Apt-Get
alias agi='apt-get install'
alias agu='apt-get update'
alias agg='apt-get upgrade'
alias agar='apt-get autoremove'

# RC Files
alias vrc='v ~/.vimrc'
alias zrc='v ~/.zshrc && source ~/.zshrc'
alias brc='v ~/.bashrc && source ~/.bashrc'

# Better history
# # Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Virtualenvwrapper setup shit
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel

# Add NPM and NOD to path
export PATH=~/.npm-global/bin:$PATH
export WORKON_HOME=/home/phil/.virtualenvs
export PROJECT_HOME=/home/phil/Devel
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/work

# Add local bin
export PATH=~/.local/bin:$PATH

# Run SSH-Agent and add github key
eval `ssh-agent` &>> /dev/null
ssh-add $HOME/.ssh/gh_rsa &>> /dev/null

source "/home/phil/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
