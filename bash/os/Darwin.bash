# bashrc for OSX

# Setup homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# Set up bash completion.
BASH_COMPLETION="$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
[ -f $BASH_COMPLETION ] && source $BASH_COMPLETION

# Set up git completion & prompt functions.
BREW_GIT_PREFIX="$(brew --prefix git)"
GIT_COMPLETION="$BREW_GIT_PREFIX/etc/bash_completion.d/git-completion.bash"
[ -f $GIT_COMPLETION ] && source $GIT_COMPLETION
GIT_PROMPT="$BREW_GIT_PREFIX/etc/bash_completion.d/git-prompt.sh"
[ -f $GIT_PROMPT ] && source $GIT_PROMPT

# Setup iTerm2 Shell Integration
ITERM_INTEGRATION="$HOME/.iterm2_shell_integration.bash"
[ -f "$ITERM_INTEGRATION" ] && source "$ITERM_INTEGRATION"

## Environment Variables
export CLICOLOR=1

## FUNCTIONS
logoutgui() {
	osascript -e 'tell application "System Events" to log out'
	builtin logout
}
