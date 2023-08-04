#bashrc for ubuntu
[ -n "$BASH_COMPLETION" ] || export BASH_COMPLETION=/etc/bash_completion
[ -f $BASH_COMPLETION ] && source $BASH_COMPLETION

# Override the global alias to also specify color, because _sigh_
alias l="l --color=auto"
