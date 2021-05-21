# bashrc functions

function parse_git_branch {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	br=${ref#refs/heads/}
	if [[ "master" == "$br" ]]; then
		echo "("${RED}${br}${RESET}")";
	else
		echo "("${ref#refs/heads/}")"
	fi
}

function marked() {
	APP="Marked 2.app"
	if [ $1 ]; then
		open -a "$APP" $1
	else
		open -a "$APP"
	fi
}

function op-signin() {
	eval $(op signin borzilleri)
}
