# bashrc for OSX

PROMPT_COMMAND=$PROMPT_COMMAND'echo -ne "\033]0;${PWD/#$HOME/~}\007";'

# TODO: this doesn't seem to be working for ssh prompts?
source "$(brew --prefix)/etc/bash_completion"

# Setup iTerm2 Shell Integration, if it exists.
source "$BASHRC_ROOT/iterm2_shell_integration.bash"

## EXPORTS
export CLICOLOR=1

## ALIASES
alias cdopen="drutil tray eject"
alias cdclose="drutil tray close"

if [[ $(which brew) && !$(brew ls --versions sshrc) ]]; then
	_completion_loader ssh 2>/dev/null # for bash-completion >= 1.90, bash >= 4.1
	eval $(complete -p ssh | sed 's/ ssh$/ sshrc/')
fi

## FUNCTIONS

logoutgui() {
	osascript -e 'tell application "System Events" to log out'
	builtin logout
}
