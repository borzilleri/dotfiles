# bashrc for macOS (Darwin)

# Setup homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# Set up bash completion.
include "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"

# Git Bash Completion
include "$HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash"
# Git Prompt
include "$HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh"

# 1Password bash completion
[ -n "$(command -v op)" ] && source <(op completion bash)

# Setup iTerm2 Shell Integration
include "$BASHRC_ROOT/.iterm2_shell_integration.bash"

## Environment Variables
export CLICOLOR=1

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# Add additional executables to our path.
PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

## FUNCTIONS
logoutgui() {
	osascript -e 'tell application "System Events" to log out'
	builtin logout
}
