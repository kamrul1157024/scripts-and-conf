export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
activate-localdev(){
  pyenv activate localdev
}
terminal="zsh"
source ~/scripts-and-conf/source.sh
export COMPOSE_DOCKER_CLI_BUILD=1
