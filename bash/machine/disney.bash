export MAVEN_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(jenv init -)"

# JIRA_API_TOEN
export JIRA_AUTH_TYPE="bearer"
export GH_HOST="github.disney.com"

export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin:${HOME}/Library/Application Support/JetBrains/Toolbox/scripts"

#export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

#alias jira-work="jira issue list -a$(jira me) -s'In Progress' --plain --no-headers --columns KEY"
