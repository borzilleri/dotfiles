# dotfiles

Install with a machine name:

```bash
curl -fsSL https://raw.githubusercontent.com/borzilleri/dotfiles/master/install.sh | bash -s -- sdf-1
```

Or without, to be prompted:

```bash
curl -fsSL https://raw.githubusercontent.com/borzilleri/dotfiles/master/install.sh | bash
```

Requires `git`. The repo is cloned to `$XDG_CONFIG_HOME/dotfiles` (or `~/.config/dotfiles`),
then each sub-directory's `install.sh` is run. Valid machine names are listed in `machines.txt`.
