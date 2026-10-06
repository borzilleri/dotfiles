#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MACHINE="${DOTFILES_MACHINE:?no machine set; re-run with --machine NAME}"

DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/git"
mkdir -p "$DEST_DIR"

ln -sfn "$SRC_DIR/gitignore" "$DEST_DIR/ignore"
echo "Linked $DEST_DIR/ignore -> $SRC_DIR/gitignore"

sed -e "s|{pwd}|$SRC_DIR|g" -e "s|{machine}|$MACHINE|g" \
  "$SRC_DIR/template.gitconfig" > "$DEST_DIR/config"
echo "Wrote $DEST_DIR/config ($MACHINE)"
