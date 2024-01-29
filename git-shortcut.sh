source ~/scripts-and-conf/common.sh
alias glog="git log --graph --oneline"
alias gd="git diff"
alias ga="git add $1"
alias gc="git commit -m $1"
alias gp="git push kamrul HEAD"
gri(){
  eval "git rebase -i HEAD~$1"
}
alias gpull="git pull newscred master"
alias grename="git remote rename origin kamrul"

function gh-review(){
  repo_name=$(echo "$1"|cut -d "/" -f 5)
  cd ~/workspace/$repo_name
  gh pr checkout -f $1
}

function fork-and-add-remote(){
  gh repo fork "newscred/$1" --clone=False
  git remote rm kamrul
  git remote add kamrul "git@github.com:kamrul1157024/$1.git"
}

function gh-remote(){
  repoName=$(getRepoNameFromPwd)
  fork-and-add-remote "$repoName"

  echo "All available remotes:"

  git remote -v
}

fork-all(){
  repos=$(ls -d */)
  for repo in $repos; do
    cd ~/workspace/$repo
    gh-remote
    git fetch kamrul
  done
}
