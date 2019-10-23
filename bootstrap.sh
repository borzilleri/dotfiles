#!/bin/bash
DIR="$(cd -P "$(dirname "$0")" && pwd)"
F=""
if [[ $1 && "$1" == "-f" ]]; then
	F="f"
fi

# Setup SSH Directory, if not already done.
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# SSH Config
ln -sn$F "$DIR/ssh/config" "$HOME/.ssh/config"

# Shell configuration
ln -sn$F "$DIR/bash/bash_profile" "$HOME/.bash_profile"
ln -sn$F "$DIR/bash/bashrc" "$HOME/.bashrc"
ln -sn$F "$DIR/bash/inputrc" "$HOME/.inputrc"
ln -sn$F "$DIR/bash/hushlogin" "$HOME/.hushlogin"
ln -sn$F "$DIR/bash/ackrc" "$HOME/.ackrc"

# sshrc config
ln -sn$F "$DIR/bash/sshrc.bash" "$HOME/.sshrc"
ln -sn$F "$DIR/sshrc.d" "$HOME/.sshrc.d"

# vimrc
ln -sn$F "$DIR/vim/vimrc" "$HOME/.vimrc"

# git
ln -sn$F "$DIR/git/gitignore" "$HOME/.gitignore"
cp "$DIR/git/gitconfig.tpl" "$HOME/.gitconfig"
