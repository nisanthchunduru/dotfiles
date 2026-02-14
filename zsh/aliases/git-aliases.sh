alias g=git
alias gs='git status'
alias gra='git remote add'
alias gcl='git clone'
alias gb='git branch --sort=-creatordate'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcop='git checkout -' # Checkout to previous git branch
alias gc='git commit'
alias gl='git log'
alias gcp='git cherry-pick'
alias gri='git rebase -i'
alias gf='git fetch'
alias gfa='git fetch --all'
alias grm='git rm'
alias gst='git stash'
alias git-stash-staged='git stash push --staged'
alias git-stash-unstaged='git stash push -k'
alias git-discard-changes='git checkout --'
# Borrowed from https://www.damirscorner.com/blog/posts/20210423-ChangingUrlsOfGitSubmodules.html
alias git-clone-submodules='git submodule update --init --recursive --remote'
alias add-gitignore-local='ln -s .git/info/exclude .gitignore_local'
alias delete-all-branches-except-main='git branch | grep -v 'main' | xargs git branch -D'
alias delete-all-branches-except-master='git branch | grep -v 'master' | xargs git branch -D'
# alias delete_remote_branch='git push -d origin'
alias delete-remote-branch='git push -d origin ${1:-$(git symbolic-ref --short HEAD)}'
alias rebase-latest='git pull --rebase origin'
alias current-branch='git branch --show-current'

# An alias/function to checkout to the given branch and delete the previous branch
gbDco() {
  if [ -z "$1" ]; then
    echo "Usage: gbDco <branch-name>"
    return 1
  fi
  local previous_branch=$(git branch --show-current)
  git checkout "$1" && git branch -D "$previous_branch"
}

