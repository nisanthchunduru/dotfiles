gpu () {
	if [ -f $1 ]; then
		git push $@
	else
    current_git_branch=`git rev-parse --abbrev-ref HEAD`
		git push origin $current_git_branch
	fi
}
