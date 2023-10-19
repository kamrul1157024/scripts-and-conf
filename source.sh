source ~/scripts-and-conf/git-shortcut.sh

nvim(){
  tmux rename-window "$(basename $(pwd))"
  command nvim $1
}

