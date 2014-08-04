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

function git_prune_remotes {
	if [ $# -lt 1 ]; then
		echo "usage: gprune <remote>";
	else
		git fetch -p $1;
		git branch -r --merged | grep -v master | grep -e $1 \
			| sed -e s,$1/,:, | xargs git push $1;
	fi
}
