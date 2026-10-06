# Adding a component

A component is a top-level directory with an `install.sh`. The root `install.sh` discovers it automatically, runs it, and records its state in the manifest. There's no registry to edit.

Rules for `<name>/install.sh`:

- Start with `#!/usr/bin/env bash`, `set -euo pipefail`, and `SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"`.
- Stay compatible with bash 3.2 (macOS `/bin/bash`): no associative arrays, no `mapfile`, no `${x,,}`. Use only tools present by default on macOS and Linux, and use flags that behave the same on BSD and GNU (e.g. `ln -sfn`, not `ln -F`).
- Make it idempotent, because `update` re-runs it: use `ln -sfn` and `mkdir -p`, and overwrite generated files rather than appending to them.
- Install to `${XDG_CONFIG_HOME:-$HOME/.config}/<name>`. Use `$HOME` dotfiles only when the tool requires them.
- Symlink static files. Generate per-install files from a `local.template.*` / `template.*` with `sed` placeholders (`{pwd}`, `{machine}`).
- If the component needs the machine name, use `MACHINE="${DOTFILES_MACHINE:?no machine set; re-run with --machine NAME}"`. The root always passes it; it's empty when the user chose no machine. Never prompt.
- Print one line per action: `Linked X -> Y` or `Wrote X`.
- Never read or write the manifest, and never prompt. Only the root `install.sh` does that.
- Exit non-zero on failure, so the component isn't recorded as installed.

Test against a throwaway home:

```
HOME=$T XDG_CONFIG_HOME=$T/.config XDG_STATE_HOME=$T/.local/state /bin/bash ./install.sh install <name>
```
