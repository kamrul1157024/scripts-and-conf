source ~/scripts-and-conf/common.sh
alias glog="git log --graph --oneline"
alias gd="git diff"
alias ga="git add $1"
alias gam="git commit --amend --no-edit"
alias gc="git commit -m $1"
alias gp="git push kamrul HEAD"

function get-root-branch() {
      if [ "`git branch --list master`" ]; then
		root_branch="master"
      elif [ "`git branch --list main`" ]; then
		root_branch="main"
      else
		echo "Neither 'master' nor 'main' branch exists."
		return 1
      fi
}

function gri() {
	eval "git rebase -i HEAD~$1"
}

function grbm() {
	get-root-branch
	git fetch newscred "$root_branch"
	git rebase "newscred/$root_branch"
}

function gcm() {
	get-root-branch
	git checkout "$root_branch"
}

function grh() {
	git fetch "$1" "$2"
	git reset --hard "$1/$2"
}

function grhnm() {
	get-root-branch
	grh newscred "$root_branch"
}

function gpull() {
	get-root-branch
	echo "Pulling from newscred $root_branch"
	git pull newscred "$root_branch"
}

alias grename="git remote rename origin kamrul"

function fetch-and-checkout() {
	echo "----------------------------------------------------------"
	echo "Fetching PR $1"
	echo "----------------------------------------------------------"
	repo_name=$(echo $1 | cut -d "/" -f 5)
	cd ~/workspace/$repo_name
	gh pr checkout -f $1
}

function gh-review() {
	local OPTIND
	local OPTARG
	while getopts "s:r:" o; do
		pr_link=$OPTARG
		fetch-and-checkout $pr_link
		case "${o}" in
		s)
			skip_rebase=true
			echo "----------------------------------------------------------"
			echo "Skipping rebase to newscred master"
			echo "----------------------------------------------------------"
			;;
		r)
			echo "----------------------------------------------------------"
			echo "Rebasing to newscred master"
			echo "----------------------------------------------------------"

			grm
			;;
		esac
		printf "\n\n"
		echo "-------------PR Descriptions------------------------------"
		gh pr view $pr_link
		echo "----------------------------------------------------------"
		printf "\n\n"
	done
}

function fork-and-add-remote() {
	gh repo fork "newscred/$1" --clone=False
	git remote rm kamrul
	git remote add kamrul "git@github.com:kamrul1157024/$1.git"
}

function gh-remote() {
	repoName=$(getRepoNameFromPwd)
	fork-and-add-remote "$repoName"

	echo "All available remotes:"

	git remote -v
}

function fork-all() {
	repos=($(ls -d */))
	for repo in $repos; do
		cd ~/workspace/$repo
		gh-remote
		git fetch kamrul
	done
}

gh-find() {
	pr_info=$(gh pr list --search $1 --state merged)
	if [[ -z "$pr_info" ]]; then
		echo "No Pr found with $1 commit"
		return
	fi
	pr_info_arr=($pr_info)
	pr_id="${pr_info_arr[0]}"
	gh pr view $pr_id
}
