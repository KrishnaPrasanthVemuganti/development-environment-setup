# Note: Make sure to change [username] to your username

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/home/[username]/.oh-my-zsh"

# ZSH Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Skip the verification of [oh-my-zsh] insecure directories
ZSH_DISABLE_COMPFIX="true"

# Which plugins would you like to load?
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fnm
export PATH=/home/[username]/.fnm:$PATH
eval "`fnm env`"

# Add SSH Key
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519

# Aliases
# For a full list of active aliases, run `alias`.
alias lsl="ls -lrt"
alias zshconfig="code .zshrc"
alias zshreset="source ~/.zshrc"

# User functions
function acp() {
  git add .
  git commit -m "$1"
  git push
}

function npmUpdate(){
  npm update -g
}

function npml(){
  npm list -g --depth 0
  npm list --depth 0
}

function nnv(){
  node -v && npm -v
}

function cls(){
  clear
}

function clnbh(){
  history -c
  exit
}
