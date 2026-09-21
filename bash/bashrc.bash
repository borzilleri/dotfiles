# .bashrc

# Base helper function for including other bashrc files.
function include {
	[ -s "$1" ] && source "$1"
}

# The root directory for this file.
export BASHRC_ROOT=$(dirname "$(readlink -fn "${BASH_SOURCE[0]}")")

# Root directory for the dotfiles folder.
export DOTFILES_ROOT=$(dirname "$BASHRC_ROOT")

# Local bash configuration root directory.
export LOCAL_BASH_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/bash"

# Include base bashrc files.
include "$BASHRC_ROOT/lib/base.bash"
include "$BASHRC_ROOT/lib/colors.bash"
include "$BASHRC_ROOT/lib/functions.bash"
include "$BASHRC_ROOT/lib/aliases.bash"

# Include OS Specific bashrc file.
include "$BASHRC_ROOT/os/$(uname -s).bash"

# Include Non-Portable Machine Specific bashrc file
# This file should include the machine-specific bashrc file,
# as well as keys/secrets that CANNOT leave a machine.
include "$LOCAL_BASH_ROOT/local.bash"

# Set additional PATH entries, and export the PATH variable.
# This should be LAST, to ensure all other includes have had a chance to modify
# the PATH before we export it.
include "$BASHRC_ROOT/lib/paths.bash"

# Export our shell prompt & prompt command
prompt_func () {
	branch=$(__git_ps1 '%s');
	[ -e "$HOME/.iterm2/it2setkeylabel" ] && $HOME/.iterm2/it2setkeylabel \
		set status "${branch:-none}";
}
export PS1="\h:\W${GREEN}\$(__git_ps1 ':%s')${RESET}\$ ";
export PROMPT_COMMAND="prompt_func;"
