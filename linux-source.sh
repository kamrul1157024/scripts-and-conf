eval "$(oh-my-posh init bash)"

source ~/scripts-and-conf/source.sh

eval "$(oh-my-posh init bash --config ~/scripts-and-conf/themes/oh-my-posh/half-life.omp.json)"

function ssh-init() {
        eval $(ssh-agent -s)
        ssh-add
}


