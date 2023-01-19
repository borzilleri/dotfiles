# bashrc for OSX
BREW_PREFIX="$(brew --prefix)"
PROMPT_COMMAND=$PROMPT_COMMAND'echo -ne "\033]0;${PWD/#$HOME/~}\007";'

# Set up bash completion.
[ -f "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ] &&  source "$BREW_PREFIX/etc/profile.d/bash_completion.sh"

# Setup iTerm2 Shell Integration, if it exists.
ITERM_INTEGRATION="$HOME/.iterm2_shell_integration.bash"
[ -f "$ITERM_INTEGRATION" ] && source "$ITERM_INTEGRATION"

## EXPORTS
export CLICOLOR=1

if [[ $(which brew) && !$(brew ls --versions sshrc) ]]; then
	_completion_loader ssh 2>/dev/null # for bash-completion >= 1.90, bash >= 4.1
	eval $(complete -p ssh | sed 's/ ssh$/ sshrc/')
fi

## FUNCTIONS

logoutgui() {
	osascript -e 'tell application "System Events" to log out'
	builtin logout
}
