# History Control, ignore spaces & ignore dupes
export HISTCONTROL=ignoreboth;
export LANG="en_US.UTF-8"
export LC_COLLATE="C"
export PAGER="less"
export EDITOR="vim"
export LESSCHARSET="utf-8"

# Shell Options
shopt -s cdspell # correct minor directory spelling errors in cd cmd.
shopt -s checkwinsize # Refresh window size after each cmd
shopt -s cmdhist # save all lines of multi-line cmds to same history entry
shopt -s histappend # append to history file instead of overwrite

# Ignore duplicate commands in history
#shopt -s histredup # ignore duplicate commands in history

# Check window size after each command and update LINES and COLUMNS
shopt -s checkwinsize
