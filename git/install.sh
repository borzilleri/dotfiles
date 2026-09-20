#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CHOICE="${1:-}"
while [[ "$CHOICE" != "disney" && "$CHOICE" != "sdf1" ]]; do
  if [[ -n "$CHOICE" ]]; then echo "Invalid choice: $CHOICE" >&2; fi
  read -r -p "Which config? (disney/sdf1): " CHOICE || { echo "No choice given." >&2; exit 1; }
done

DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/git"
mkdir -p "$DEST_DIR"

ln -sfn "$SRC_DIR/gitignore" "$DEST_DIR/ignore"
echo "Linked $DEST_DIR/ignore -> $SRC_DIR/gitignore"

sed -e "s|{pwd}|$SRC_DIR|g" -e "s|{choice}|$CHOICE|g" \
  "$SRC_DIR/template.gitconfig" > "$DEST_DIR/config"
echo "Wrote $DEST_DIR/config ($CHOICE)"
