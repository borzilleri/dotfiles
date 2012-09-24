#!/bin/bash

DIR="$(cd -P "$(dirname "$0")" && pwd)"
F=""
if [[ $1 && "$1" == "-f" ]]; then
	F="-f"
fi

ln -s $F "$DIR/vimrc" "$HOME/.vimrc"

