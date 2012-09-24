#!/bin/bash
DIR="$(cd -P "$(dirname "$0")" && pwd)"
F=""
if [[ $1 && "$1" == "-f" ]]; then
	F="-f"
fi

ln -s $F "$DIR/bash/bash_profile" "$HOME/.bash_profile"
ln -s $F "$DIR/bash/bashrc" "$HOME/.bashrc"
ln -s $F "$DIR/bash/inputrc" "$HOME/.inputrc"
ln -s $F "$DIR/bash/hushlogin" "$HOME/.hushlogin"
ln -s $F "$DIR/bash/ackrc" "$HOME/.ackrc"
ln -s $F "$DIR/git/gitignore" "$HOME/.gitignore"

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
ln -s $F "$DIR/ssh/config" "$HOME/.ssh/config"
