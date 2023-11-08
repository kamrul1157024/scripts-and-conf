
export WORKON_HOME=~/Envs
mkdir -p $WORKON_HOME
source ~/.local/bin/virtualenvwrapper.sh

function ssh-init() {
        eval $(ssh-agent -s)
        ssh-add
}

source ~/scripts-and-conf/source.sh
