export GOPATH="$HOME/src/go:$HOME/Projects/go"
export GOROOT="$(brew --prefix golang)/libexec"
PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin:${HOME}/Library/Application Support/JetBrains/Toolbox/scripts"


export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
