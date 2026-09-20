#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -snF "$SRC_DIR/inputrc.bash" "$HOME/.inputrc"
ln -snF "$SRC_DIR/hushlogin" "$HOME/.hushlogin"
