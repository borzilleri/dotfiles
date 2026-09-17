export AWSMYID_PASS="op://Disney/MyID/password"

export SBT_OPTS="-Xmx2G -Xss2m"
export MAVEN_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n
eval "$(jenv init -)"

# AWS CLI completions
complete -C "$HOMEBREW_PREFIX/bin/aws_completer" aws

eval "$(~/.local/bin/aix completion bash)"

export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang)/libexec"
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
export APOLLO_TELEMETRY_DISABLED=true


include "${SDKMAN_DIR}/bin/sdkman-init.sh"

function myid-aws() {
  op run -- awsmyid login
}

export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin:${HOME}/Library/Application Support/JetBrains/Toolbox/scripts:${HOME}/Library/Application Support/Coursier/bin"
