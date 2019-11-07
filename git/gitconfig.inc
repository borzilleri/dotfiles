[alias]
	st = status -b --ignore-submodules=dirty
	ci = commit
	co = checkout
	master = !git checkout master && git pull origin master
	unstage = reset --soft HEAD^

[branch]
	autosetuprebase = always

