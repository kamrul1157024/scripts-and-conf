function getRepoNameFromPwd() {
	repoName=$(pwd | awk -F "/" '{print $NF}')
	echo $repoName
}

function exec-if-not-exit(){
  if ! command -v $1 &> /dev/null
  then
      echo "<the_command> could not be found"
      eval  $2
  fi
}

# function date(){
#   command date +"%Y-%m-%dT%H:%M:%S%z"
# }
