alias ccat='pygmentize -g -O style=github-dark,linenos=1'
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias ghr="gh-review -r $1"

function getRepoNameFromPwd() {
	repoName=$(pwd | awk -F "/" '{print $NF}')
	echo $repoName
}

function exec-if-not-exit() {
	if ! command -v $1 &>/dev/null; then
		echo "<the_command> could not be found"
		eval $2
	fi
}

function split-string() {
	IFS=$1
	read -ra ADDR <<<"$2"
	echo $ADDR
}

function tr() {
	eval "source ~/.${terminal}rc"
}

alias k="kubectl $1"

function run-colab-server() {
	docker run -p 127.0.0.1:9000:8080 us-docker.pkg.dev/colab-images/public/runtime
}

# function date(){
#   command date +"%Y-%m-%dT%H:%M:%S%z"
# }
