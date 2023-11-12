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

open(){
  export IFS="|"
  window=0
  for repoName in $1; do
    if [$window -eq 0]; then
      tmux rename-window -t $session:$window $repoName
    else
      tmux new-window -t $session:$window -n $repoName
    fi

    tmux send-keys -t $session:$window "cd ~/workspace/$repoName" C-m

    window=$((window+1))
  done
}

nc-editor(){
  export session="editor"
  tmux kill-session $session
  tmux new-session -d -s $session
  repoList="cmp-client|cmp-server|content-repo/content-repo|assets"
  open "$repoList"
  tmux attach-session -t $session
}

