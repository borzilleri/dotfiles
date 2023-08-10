include "$HOME/Projects/identity-helper-scripts/functions.bash"

export MAVEN_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n
eval "$(jenv init -)"
exportSBT_OPTS="-Xmx2G -Xss2m"

export AWSMYID_PASS="op://Disney/MyID/password"

complete -C "$HOMEBREW_PREFIX/bin/aws_completer" aws

export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin:${HOME}/Library/Application Support/JetBrains/Toolbox/scripts"
export GH_HOST="github.disney.com"
