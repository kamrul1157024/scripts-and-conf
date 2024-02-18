source ~/scripts-and-conf/git-shortcut.sh
source ~/scripts-and-conf/newscred.sh

nvim(){
  tmux rename-window "$(basename $(pwd))"
  command nvim $1
}

pnpm-setup(){
  curl -fsSL https://get.pnpm.io/install.sh | sh -
}

create-ts-app(){
  if [ -z "$1" ]
  then
    echo "Add folder name"
  fi

  git clone git@github.com:kamrul1157024/node-express-ts-minimal-boilerplate.git $1 2>1  1> /dev/null

  cd $1
  rm -rf .git
  git init 2>1 1> /dev/null
  git add . 2>1 1> /dev/null
  git commit -m "Intitalized TS appp" 2>1 1> /dev/null
  exec-if-not-exist pnpm "pnpm-setup"
  pnpm install
}
eval "$(oh-my-posh init $terminal --config ~/scripts-and-conf/themes/oh-my-posh/half-life.omp.json )"

