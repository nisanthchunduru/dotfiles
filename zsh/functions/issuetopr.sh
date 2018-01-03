# @example
#   issuetopr 1234
issuetopr () {
  git_organization=`git config --get remote.origin.url | cut -d: -f2 | cut -d/ -f1`
  git_branch=`git rev-parse --symbolic-full-name --abbrev-ref HEAD`
  issue_number=$1

  hub pull-request -i $issue_number -h $git_organization:$git_branch # $1 is the issue number
}
