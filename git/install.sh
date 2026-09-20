#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CHOICE="${1:-}"
while [[ "$CHOICE" != "disney" && "$CHOICE" != "sdf1" ]]; do
  if [[ -n "$CHOICE" ]]; then echo "Invalid choice: $CHOICE" >&2; fi
  read -r -p "Which config? (disney/sdf1): " CHOICE || { echo "No choice given." >&2; exit 1; }
done

ln -sfn "$SRC_DIR/gitignore" "$HOME/.gitignore"
echo "Linked $HOME/.gitignore -> $SRC_DIR/gitignore"

sed -e "s|{pwd}|$SRC_DIR|g" -e "s|{choice}|$CHOICE|g" \
  "$SRC_DIR/template.gitconfig" > "$HOME/.gitconfig"
echo "Wrote $HOME/.gitconfig ($CHOICE)"
