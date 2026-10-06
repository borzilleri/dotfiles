# dotfiles

Install, choosing components interactively:

```bash
curl -fsSL https://raw.githubusercontent.com/borzilleri/dotfiles/main/install.sh | bash -s -- --machine sdf-1
```

Requires `git`. The repo is cloned to `$XDG_CONFIG_HOME/dotfiles` (or `~/.config/dotfiles`).
Valid machine names are listed in `machines.txt`. If `--machine` is omitted you'll be prompted
once (blank for none); pass `--machine NAME` on any later run to set or change it.

## Usage

```
install.sh [--machine NAME] [COMMAND] [COMPONENT...]

  (none)        Prompt for each component not yet installed or skipped
  install C...  Install components (and mark them installed)
  skip C...     Mark components as skipped
  update        Pull the repo, re-install installed components, then prompt for any new ones
  status        Show the state of every component
```

Components are the top-level directories with an `install.sh` (bash, ghostty, git, home.rc, vim).

Installed/skipped state and the chosen machine are kept in
`$XDG_STATE_HOME/dotfiles/manifest` (or `~/.local/state/dotfiles/manifest`).
