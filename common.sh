function getRepoNameFromPwd(){
  repoName=$(pwd|awk -F "/" '{print $NF}')
  echo $repoName
}

