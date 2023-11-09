source ~/scripts-and-conf/common.sh
workon localdev

restart(){
  nc-docker down $1
  nc-docker up $1
}

shell(){
  nc-docker shell $1
}

# EX: Run `e yarn lint` on repo it should be able to run this command inside the docker container
e(){
  command="nc-docker exec $(getRepoNameFromPwd) \"$@\""
  echo $command
  eval $command
}

