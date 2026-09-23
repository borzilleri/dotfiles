#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/vim"
DEST="$DEST_DIR/vimrc"

mkdir -p "$DEST_DIR"
ln -sfn "$SRC_DIR/vimrc.vim" "$DEST"
echo "Linked $DEST -> $SRC_DIR/vimrc.vim"
