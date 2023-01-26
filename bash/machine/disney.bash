export MAVEN_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n
eval "$(jenv init -)"

complete -C "$HOMEBREW_PREFIX/bin/aws_completer" aws

# JIRA_API_TOEN
export JIRA_AUTH_TYPE="bearer"
export GH_HOST="github.disney.com"

export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin:${HOME}/Library/Application Support/JetBrains/Toolbox/scripts"

alias jira-work="jira issue list -a$(jira me) -s'In Progress' --plain --no-headers --columns KEY"
AWS_EXPORT_CREDS_PATH=""
function aws-credentials-export() {
  source $AWS_EXPORT_CREDS_PATH
}
