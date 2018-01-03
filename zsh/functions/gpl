gpl () {
	if [ -f $1 ]; then
		git pull $@
	else
    current_git_branch=`git rev-parse --abbrev-ref HEAD`
		git pull origin $current_git_branch
	fi
}
