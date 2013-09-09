# bashrc for OSX

# TODO: this doesn't seem to be working for ssh prompts?
source `brew --prefix`/etc/bash_completion

alias l="ls -loGhF";
alias cdopen="drutil tray eject";
alias cdclose="drutil tray close";


if command -v hub >/dev/null 2>&1; then
	eval "$(hub alias -s)"
fi

if [ -d /usr/local/share/npm ]; then
	PATH="$PATH:/usr/local/share/npm/bin"
fi

PATH="$PATH:/Developer/Tools"

export CC='gcc-4.2'

logoutgui() {
	osascript -e 'tell application "System Events" to log out'
	builtin logout
}
