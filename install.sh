#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/borzilleri/dotfiles.git"

die() {
  echo "$*" >&2
  exit 1
}

# Pull (or clone) the repo, then continue in its install.sh, which may have changed.
sync_repo_and_reexec() {
  if [[ -e "$SRC_DIR/.git" ]]; then
    echo "==> Updating $SRC_DIR"
    git -C "$SRC_DIR" pull --ff-only
  else
    echo "==> Cloning $REPO_URL to $SRC_DIR"
    mkdir -p "$(dirname "$SRC_DIR")"
    git clone "$REPO_URL" "$SRC_DIR"
  fi
  git -C "$SRC_DIR" submodule update --init --recursive ||
    echo "Warning: submodule checkout failed, run it manually later." >&2
  DOTFILES_NO_PULL=1 exec bash "$SRC_DIR/install.sh" "$@"
}

# Piped from curl: BASH_SOURCE is unset, so there is no checkout to install from.
if [[ -n "${BASH_SOURCE[0]:-}" && -f "${BASH_SOURCE[0]}" ]]; then
  SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
  command -v git >/dev/null 2>&1 || die "git is required to bootstrap the dotfiles."
  SRC_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles"
  sync_repo_and_reexec "$@"
fi

usage() {
  cat <<EOF
Usage: install.sh [--machine NAME] [COMMAND] [COMPONENT...]

Commands:
  (none)        Prompt for each component not yet installed or skipped
  install C...  Install components (and mark them installed)
  skip C...     Mark components as skipped
  update        Pull the repo, re-install installed components,
                then prompt for any new ones
  status        Show the state of every component

Components: ${COMPONENTS[*]}
Manifest:   $MANIFEST
EOF
}

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles"
MANIFEST="$STATE_DIR/manifest"

manifest_get() {
  [[ -f "$MANIFEST" ]] || return 0
  awk -F= -v k="$1" '$1 == k { v = substr($0, length(k) + 2) } END { if (v != "") print v }' "$MANIFEST"
}

manifest_has() {
  [[ -f "$MANIFEST" ]] && awk -F= -v k="$1" '$1 == k { f = 1 } END { exit !f }' "$MANIFEST"
}

manifest_set() {
  local tmp="$MANIFEST.tmp.$$"
  mkdir -p "$STATE_DIR"
  if [[ -f "$MANIFEST" ]]; then
    awk -F= -v k="$1" '$1 != k' "$MANIFEST" > "$tmp"
  else
    : > "$tmp"
  fi
  printf '%s=%s\n' "$1" "$2" >> "$tmp"
  mv "$tmp" "$MANIFEST"
}

COMPONENTS=()
for dir in "$SRC_DIR"/*/; do
  dir="${dir%/}"
  if [[ -f "$dir/install.sh" ]]; then COMPONENTS+=("${dir##*/}"); fi
done

in_list() {
  local needle="$1" item
  shift
  for item in "$@"; do
    if [[ "$item" == "$needle" ]]; then return 0; fi
  done
  return 1
}

MACHINES=()
if [[ -f "$SRC_DIR/machines.txt" ]]; then
  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ -n "$line" ]]; then MACHINES+=("$line"); fi
  done < "$SRC_DIR/machines.txt"
fi

is_machine() {
  [[ -n "$1" ]] && in_list "$1" ${MACHINES[@]+"${MACHINES[@]}"}
}

# Read answers from the terminal: stdin may still be the curl pipe.
{ exec <>/dev/tty; } 2>/dev/null || true
HAVE_TTY=0
if [[ -t 0 ]]; then HAVE_TTY=1; fi

ask_yn() {
  local answer=""
  read -r -p "$1 [y/N] " answer || answer=""
  case "$answer" in
    [yY] | [yY][eE][sS]) return 0 ;;
  esac
  return 1
}

# Sets MACHINE from --machine, the manifest, or a prompt (saved to the manifest).
# Blank means no machine; components that need one will fail.
MACHINE=""
MACHINE_GIVEN=0
resolve_machine() {
  if [[ $MACHINE_GIVEN -eq 1 ]]; then return 0; fi
  if manifest_has machine; then
    MACHINE="$(manifest_get machine)"
    if [[ -z "$MACHINE" ]] || is_machine "$MACHINE"; then return 0; fi
    echo "Saved machine is no longer valid: $MACHINE" >&2
  fi
  MACHINE=""
  if [[ $HAVE_TTY -eq 0 ]]; then
    echo "No machine set (pass --machine NAME)" >&2
    return 0
  fi
  while true; do
    read -r -p "Machine? [${MACHINES[*]:-}] (blank for none): " MACHINE || MACHINE=""
    if [[ -z "$MACHINE" ]] || is_machine "$MACHINE"; then break; fi
    echo "Unknown machine: $MACHINE" >&2
  done
  manifest_set machine "$MACHINE"
}

FAILED=()
run_component() {
  local name="$1" script="$SRC_DIR/$1/install.sh"
  echo
  echo "==> $name"
  if DOTFILES_MACHINE="$MACHINE" bash "$script"; then
    manifest_set "$name" installed
  else
    FAILED+=("$name")
  fi
}

skip_component() {
  manifest_set "$1" skipped
  echo "Skipped $1"
}

# Prompt for components with no recorded state; without a terminal, just list them.
prompt_unrecorded() {
  local c
  for c in "${COMPONENTS[@]}"; do
    if [[ -n "$(manifest_get "$c")" ]]; then continue; fi
    if [[ $HAVE_TTY -eq 0 ]]; then
      echo "New component: $c (install.sh install $c)"
    elif ask_yn "Install $c?"; then
      run_component "$c"
    else
      skip_component "$c"
    fi
  done
}

ARGS=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --machine) MACHINE="${2:-}"; MACHINE_GIVEN=1; shift 2 || shift ;;
    --machine=*) MACHINE="${1#*=}"; MACHINE_GIVEN=1; shift ;;
    -h | --help) usage; exit 0 ;;
    -*) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
    *) ARGS+=("$1"); shift ;;
  esac
done

CMD="${ARGS[0]:-}"
NAMES=(${ARGS[@]+"${ARGS[@]:1}"})

if [[ $MACHINE_GIVEN -eq 1 ]]; then
  [[ -z "$MACHINE" ]] || is_machine "$MACHINE" || die "Unknown machine: $MACHINE [${MACHINES[*]:-}]"
  manifest_set machine "$MACHINE"
fi

for name in ${NAMES[@]+"${NAMES[@]}"}; do
  in_list "$name" "${COMPONENTS[@]}" || die "Unknown component: $name [${COMPONENTS[*]}]"
done

case "$CMD" in
  install | skip) [[ ${#NAMES[@]} -gt 0 ]] || die "$CMD: no components given" ;;
  *) [[ ${#NAMES[@]} -eq 0 ]] || die "${CMD:-install.sh}: takes no components" ;;
esac

case "$CMD" in
  "")
    [[ $HAVE_TTY -eq 1 ]] || die "No terminal to prompt on; pass components explicitly: install.sh install C..."
    resolve_machine
    prompt_unrecorded
    ;;
  install)
    resolve_machine
    for name in "${NAMES[@]}"; do run_component "$name"; done
    ;;
  skip)
    for name in "${NAMES[@]}"; do skip_component "$name"; done
    ;;
  update)
    if [[ -z "${DOTFILES_NO_PULL:-}" && -e "$SRC_DIR/.git" ]]; then
      sync_repo_and_reexec update
    fi
    resolve_machine
    for c in "${COMPONENTS[@]}"; do
      if [[ "$(manifest_get "$c")" == installed ]]; then run_component "$c"; fi
    done
    prompt_unrecorded
    ;;
  status)
    if manifest_has machine; then
      machine="$(manifest_get machine)"
    else
      machine=unset
    fi
    printf '%-10s %s\n' machine "${machine:-none}"
    for c in "${COMPONENTS[@]}"; do
      state="$(manifest_get "$c")"
      printf '%-10s %s\n' "$c" "${state:-unrecorded}"
    done
    ;;
  *)
    echo "Unknown command: $CMD" >&2
    usage >&2
    exit 1
    ;;
esac

if [[ ${#FAILED[@]} -gt 0 ]]; then
  echo
  die "Failed: ${FAILED[*]}"
fi
