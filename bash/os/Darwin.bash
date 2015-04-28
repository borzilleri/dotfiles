# bashrc for OSX

# TODO: this doesn't seem to be working for ssh prompts?
source "$(brew --prefix)/etc/bash_completion"

## EXPORTS
export CLICOLOR=1

## ALIASES
alias cdopen="drutil tray eject";
alias cdclose="drutil tray close";
alias kosh='curl -s https://api.github.com/zen | cowsay -f kosh'

## FUNCTIONS

logoutgui() {
	osascript -e 'tell application "System Events" to log out'
	builtin logout
}
