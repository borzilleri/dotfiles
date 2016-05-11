alias l="ls -ohF --color=auto"
export EDITOR="vim"
export VIMINIT="let \$MYVIMRC='$SSHHOME/.sshrc.d/vimrc' | source \$MYVIMRC"

export PS1="\u@\h:\W\$ "

source "$SSHHOME/.sshrc.d/iterm2_shell_integration.bash"

