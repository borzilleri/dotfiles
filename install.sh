#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/borzilleri/dotfiles.git"

# Piped from curl: BASH_SOURCE is unset, so there is no checkout to install from.
if [[ -n "${BASH_SOURCE[0]:-}" && -f "${BASH_SOURCE[0]}" ]]; then
  SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
  if ! command -v git >/dev/null 2>&1; then
    echo "git is required to bootstrap the dotfiles." >&2
    exit 1
  fi

  SRC_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles"
  if [[ -d "$SRC_DIR/.git" ]]; then
    echo "==> Updating $SRC_DIR"
    git -C "$SRC_DIR" pull --ff-only
  else
    echo "==> Cloning $REPO_URL to $SRC_DIR"
    mkdir -p "$(dirname "$SRC_DIR")"
    git clone "$REPO_URL" "$SRC_DIR"
  fi
  git -C "$SRC_DIR" submodule update --init --recursive ||
    echo "Warning: submodule checkout failed, run it manually later." >&2

  exec bash "$SRC_DIR/install.sh" "$@"
fi

MACHINES=()
if [[ -f "$SRC_DIR/machines.txt" ]]; then
  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ -n "$line" ]]; then MACHINES+=("$line"); fi
  done < "$SRC_DIR/machines.txt"
fi

is_machine() {
  local m
  if [[ ${#MACHINES[@]} -eq 0 ]]; then return 1; fi
  for m in "${MACHINES[@]}"; do
    if [[ "$m" == "$1" ]]; then return 0; fi
  done
  return 1
}

# Read answers from the terminal: stdin may still be the curl pipe.
# Sub-scripts inherit this, so their own prompts work too.
{ exec <>/dev/tty; } 2>/dev/null || true

prompt_machine() {
  local answer
  while true; do
    answer=""
    printf 'Machine? [%s] (blank for none): ' "${MACHINES[*]}" >&2
    read -r answer || answer=""
    if [[ -z "$answer" ]] || is_machine "$answer"; then
      echo "$answer"
      return 0
    fi
    echo "Unknown machine: $answer" >&2
  done
}

MACHINE="${1:-}"
if [[ -n "$MACHINE" ]] && ! is_machine "$MACHINE"; then
  echo "Unknown machine: $MACHINE (ignored)" >&2
  MACHINE=""
fi
if [[ -z "$MACHINE" ]]; then
  MACHINE="$(prompt_machine)"
fi

FAILED=()
for dir in "$SRC_DIR"/*/; do
  script="${dir}install.sh"
  [[ -f "$script" ]] || continue
  name="$(basename "$dir")"

  echo
  echo "==> $name"
  bash "$script" ${MACHINE:+"$MACHINE"} || FAILED+=("$name")
done

if [[ ${#FAILED[@]} -gt 0 ]]; then
  echo
  echo "Failed: ${FAILED[*]}" >&2
  exit 1
fi
