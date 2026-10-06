#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sfn "$SRC_DIR/inputrc" "$HOME/.inputrc"
echo "Linked $HOME/.inputrc -> $SRC_DIR/inputrc"

ln -sfn "$SRC_DIR/hushlogin" "$HOME/.hushlogin"
echo "Linked $HOME/.hushlogin -> $SRC_DIR/hushlogin"
