export GEM_PATH="/Users/jborzilleri/.gems/1.8"
export GEM_HOME="$GEM_PATH"
export JAVA_HOME=$(/usr/libexec/java_home)
export MVN_HOME="$(brew --prefix maven)/libexec"
export GOPATH="$HOME/src/go:$HOME/Projects/go"
export DOCKER_HOST="tcp://docker.intrepid.agile:2375"

PATH="$GEM_PATH/bin:$PATH";

PS1="\h:\W${GREEN}\$(__git_ps1 ':%s')${RESET}\$ ";

complete -C aws_completer aws

vssh() {
	cd $HOME/Projects/vagrant-mlp
	vagrant ssh
}
