export GEM_HOME='/Users/jborzilleri/.gems/1.8'
export GEM_PATH='/Users/jborzilleri/.gems/1.8'
export JAVA_HOME=$(/usr/libexec/java_home)

export MVN_HOME="/usr/local/Cellar/maven/3.0.1/libexec"
export PLAY2_HOME="/usr/local/Cellar/play/2.0.3/libexec"


PATH="$GEM_PATH/bin:$PATH";

PS1="\h:\W${GREEN}\$(__git_ps1 ':%s')${RESET}\$ ";

