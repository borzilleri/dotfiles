#bashrc for platform-agnostic aliases

alias vi='vim'
alias l='ls -ohF'
alias grep='grep --color=auto'
alias gtag='git tag | sort -V'
alias git-clean="git branch --merged master | grep -v '^[ *]*master$' | xargs git branch -d"
alias dotfiles='cd "$DOTFILES_ROOT"'

vifind() {
	if [ $# > 1 ]; then
		FIND_PATH=$1;
		FILE_NAME=$2;
	else
		FIND_PATH='.';
		FILE_NAME=$1;
	fi
	find "$FIND_PATH" -iname "$FILE_NAME" -exec vim {} \;
}
mkcd() {
	mkdir -p "$*"
	cd "$*"
}


