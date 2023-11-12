nvim(){
  tmux rename-window "$(basename $(pwd))"
  command nvim $1
}

source ~/scripts-and-conf/git-shortcut.sh
source ~/scripts-and-conf/newscred.sh

