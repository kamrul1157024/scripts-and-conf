alias glog="git log --graph --oneline"
alias gcommit="git commit -m $1"
alias gpush="git push kamrul HEAD"
alias gpull="git pull newscred master"

function gh-review(){
  repo_name=$(echo "$1"|cut -d "/" -f 5)
  cd ~/workspace/$repo_name
  gh pr checkout -f $1
}

