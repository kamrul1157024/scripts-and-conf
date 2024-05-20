export PYENV_VIRTUALENV_DISABLE_PROMPT=1
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source <(kubectl completion zsh)
activate-localdev(){
  pyenv activate localdev
}
terminal="zsh"
source ~/scripts-and-conf/source.sh
alias act="act $1 --container-architecture linux/amd64"
export COMPOSE_DOCKER_CLI_BUILD=1
