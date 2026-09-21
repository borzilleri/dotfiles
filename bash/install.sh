#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MACHINES=()
for f in "$SRC_DIR"/machine/*.bash; do
  [[ -f "$f" ]] || continue
  MACHINES+=("$(basename "$f" .bash)")
done
if [[ ${#MACHINES[@]} -eq 0 ]]; then
  echo "No machine files found in $SRC_DIR/machine" >&2
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
  read -r -p "Which machine? (${MACHINES[*]}): " MACHINE || { echo "No choice given." >&2; exit 1; }
done

ln -sfn "$SRC_DIR/bashrc.bash" "$HOME/.bashrc"
echo "Linked $HOME/.bashrc -> $SRC_DIR/bashrc.bash"

ln -sfn "$SRC_DIR/bash_profile.bash" "$HOME/.bash_profile"
echo "Linked $HOME/.bash_profile -> $SRC_DIR/bash_profile.bash"

DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bash"
mkdir -p "$DEST_DIR"

sed "s|{machine}|$MACHINE|g" "$SRC_DIR/local.template.bash" > "$DEST_DIR/local.bash"
echo "Wrote $DEST_DIR/local.bash ($MACHINE)"
