alias glog="git log --graph --oneline"
alias gcommit="git commit -m $1"
alias gpush="git push kamrul HEAD"
alias gpull="git pull newscred master"
alias grename="git remote rename origin kamrul"

function gh-review(){
  repo_name=$(echo "$1"|cut -d "/" -f 5)
  cd ~/workspace/$repo_name
  gh pr checkout -f $1
}

function fork-and-add-remote(){
  gh repo fork "newscred/$1" --clone=False
  git remote add kamrul "git@github.com:kamrul1157024/$1.git"
}

function gh-remote(){
  repoName=$(pwd|awk -F "/" '{print $NF}')
  fork-and-add-remote "$repoName"
}

