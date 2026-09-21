#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MACHINES_FILE="$(dirname "$SRC_DIR")/machines.txt"
MACHINES=()
if [[ -f "$MACHINES_FILE" ]]; then
  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ -n "$line" ]]; then MACHINES+=("$line"); fi
  done < "$MACHINES_FILE"
fi
if [[ ${#MACHINES[@]} -eq 0 ]]; then
  echo "No machines listed in $MACHINES_FILE" >&2
  exit 1
fi

is_machine() {
  local m
  for m in "${MACHINES[@]}"; do
    if [[ "$m" == "$1" ]]; then return 0; fi
  done
  return 1
}

MACHINE="${1:-}"
while ! is_machine "$MACHINE"; do
  if [[ -n "$MACHINE" ]]; then echo "Invalid machine: $MACHINE" >&2; fi
  read -r -p "Which machine? [${MACHINES[*]}]: " MACHINE || { echo "No choice given." >&2; exit 1; }
done

DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/git"
mkdir -p "$DEST_DIR"

ln -sfn "$SRC_DIR/gitignore" "$DEST_DIR/ignore"
echo "Linked $DEST_DIR/ignore -> $SRC_DIR/gitignore"

sed -e "s|{pwd}|$SRC_DIR|g" -e "s|{choice}|$MACHINE|g" \
  "$SRC_DIR/template.gitconfig" > "$DEST_DIR/config"
echo "Wrote $DEST_DIR/config ($MACHINE)"
