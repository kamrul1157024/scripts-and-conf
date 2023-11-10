
export WORKON_HOME=~/Envs
mkdir -p $WORKON_HOME
source ~/.local/bin/virtualenvwrapper.sh

function ssh-init() {
        eval $(ssh-agent -s)
        ssh-add
}

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


source ~/scripts-and-conf/source.sh

