#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MACHINE="${DOTFILES_MACHINE:?no machine set; re-run with --machine NAME}"

ln -sfn "$SRC_DIR/bashrc.bash" "$HOME/.bashrc"
echo "Linked $HOME/.bashrc -> $SRC_DIR/bashrc.bash"

ln -sfn "$SRC_DIR/bash_profile.bash" "$HOME/.bash_profile"
echo "Linked $HOME/.bash_profile -> $SRC_DIR/bash_profile.bash"

DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bash"
mkdir -p "$DEST_DIR"

sed "s|{machine}|$MACHINE|g" "$SRC_DIR/local.template.bash" > "$DEST_DIR/local.bash"
echo "Wrote $DEST_DIR/local.bash ($MACHINE)"
