# bashrc for OSX

PROMPT_COMMAND=$PROMPT_COMMAND'echo -ne "\033]0;${PWD/#$HOME/~}\007";'

# TODO: this doesn't seem to be working for ssh prompts?
source "$(brew --prefix)/etc/bash_completion"

## EXPORTS
export CLICOLOR=1

## ALIASES
alias cdopen="drutil tray eject"
alias cdclose="drutil tray close"

## FUNCTIONS

logoutgui() {
	osascript -e 'tell application "System Events" to log out'
	builtin logout
}
