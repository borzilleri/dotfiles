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
