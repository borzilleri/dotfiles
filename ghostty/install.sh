#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
DEST="$DEST_DIR/config.ghostty"

mkdir -p "$DEST_DIR"
sed "s|{pwd}|$SRC_DIR|g" "$SRC_DIR/local.template.ghostty" > "$DEST"

echo "Wrote $DEST"
