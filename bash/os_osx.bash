# bashrc for OSX

source `brew --prefix`/etc/bash_completion
#[ -n "$BASH_COMPLETION" ] || export BASH_COMPLETION=/usr/local/etc/bash_completion

alias l="ls -loGhF";
alias cdopen="drutil tray eject";
alias cdclose="drutil tray close";

PATH="$PATH:/Developer/Tools"
#PATH="$PATH:/usr/local/mysql/bin"

export CC='gcc-4.2'

logoutgui() {
	osascript -e 'tell application "System Events" to log out'
	builtin logout
}
