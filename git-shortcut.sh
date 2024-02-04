source ~/scripts-and-conf/common.sh
alias glog="git log --graph --oneline"
alias gd="git diff"
alias ga="git add $1"
alias gam="git commit --amend"
alias gc="git commit -m $1"
alias gp="git push kamrul HEAD"

gri() {
	eval "git rebase -i HEAD~$1"
}

grm() {
	git fetch newscred master
	git rebase newscred/master
}

grh() {
	git fetch $1 $2
	git reset --hard "$1/$2"
}

grhnm() {
	grh newscred master
}

alias gpull="git pull newscred master"
alias grename="git remote rename origin kamrul"

fetch-and-checkout() {
	echo "----------------------------------------------------------"
	echo "Fetching PR $1"
	echo "----------------------------------------------------------"
	repo_name=$(echo $1 | cut -d "/" -f 5)
	cd ~/workspace/$repo_name
	gh pr checkout -f $1
}

gh-review() {
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

fork-and-add-remote() {
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

fork-all() {
	repos=$(ls -d */)
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
