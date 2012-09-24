#!/bin/bash
DIR="$(cd -P "$(dirname "$0")" && pwd)"

ln -s "$DIR/bash/bash_profile" "$HOME/.bash_profile"
ln -s "$DIR/bash/bashrc" "$HOME/.bashrc"
ln -s "$DIR/bash/inputrc" "$HOME/.inputrc"
ln -s "$DIR/bash/hushlogin" "$HOME/.hushlogin"
ln -s "$DIR/bash/ackrc" "$HOME/.ackrc"
ln -s "$DIR/git/gitignore" "$HOME/.gitignore"

if [ ! -d "$HOME/.ssh" ]; then
	mkdir "$HOME/.ssh"
	chmod 700 "$HOME/.ssh"
fi
ln -s "$DIR/ssh/config" "$HOME/.ssh/config"
