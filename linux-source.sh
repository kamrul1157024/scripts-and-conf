export WORKON_HOME=~/Envs
mkdir -p $WORKON_HOME
source ~/.local/bin/virtualenvwrapper.sh

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

source ~/scripts-and-conf/source.sh


function add-passphrase-file-if-not-exist() {
	if ! [ -f ~/.ssh/passphrase ]; then
		read -s -p "Enter passphrase for SSH key: " passphrase
		touch ~/.ssh/passphrase
		echo "$passphrase" >>~/.ssh/passphrase
	fi
}

function ssh-add-file() {
	add-passphrase-file-if-not-exist

	if [ $# -ne 2 ]; then
		echo "Usage: ssh-add-pass keyfile passfile"
		exit 1
	fi

	eval $(ssh-agent -s)
	pass=$(cat $2)

	expect <<EOF
  spawn ssh-add $1
  expect "Enter passphrase"
  send "$pass\r"
  expect eof
EOF
}

ssh-add-file ~/.ssh/id_rsa ~/.ssh/passphrase >>/dev/null
