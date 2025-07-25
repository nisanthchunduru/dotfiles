# Zsh
alias reload='source ~/.zshrc'
alias symlink_dotfiles='rcup -d ~/.dotfiles/ -K'

alias l=ls
alias diff=colordiff
alias cask='brew cask'
alias pub='cat ~/.ssh/id_rsa.pub | tee >(pbcopy)' # Print ssh public key
alias sub='subdb d'
alias intel='arch -x86_64'
alias x=exit
alias ac='ruby ~/repos/dotfiles/scripts/samsung_ac.rb'
alias http_server='python3 -m http.server'

# Applications
alias co='code'
alias cu='cursor'
alias ws='windsurf'
alias sourcetree='open -a SourceTree'
alias st=sourcetree .
alias macdown='open -a MacDown'
alias typora='open -a Typora'

# Homebrew
alias brb='brew bundle --global'
alias ibrew='arch -x86_64 /usr/local/bin/brew'
alias bri='brew install'
alias brs='brew search'

# Image manipulation
alias strip_image_metadata="ruby ~/repos/dotfiles/scripts/strip_image_metadata.rb"
alias strip_location_information="ruby ~/repos/dotfiles/scripts/strip_location_information.rb"
alias heic_to_jpg="ruby ~/repos/dotfiles/scripts/heic_to_jpg.rb"

# DNS
alias use_google_dns='networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4'
alias use_cloudflare_dns='networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1'
alias use_adguard_dns='networksetup -setdnsservers Wi-Fi 176.103.130.130 176.103.130.131'
alias use_local_dns='networksetup -setdnsservers Wi-Fi 127.0.0.1'

# Git
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
alias git_stash_staged='git stash push --staged'
alias git_discard_changes='git checkout --'
# Borrowed from https://www.damirscorner.com/blog/posts/20210423-ChangingUrlsOfGitSubmodules.html
alias git_clone_submodules='git submodule update --init --recursive --remote'
alias add_gitignore_local='ln -s .git/info/exclude .gitignore_local'
alias delete_all_branches_except_main='git branch | grep -v 'main' | xargs git branch -D'
alias delete_all_branches_except_main='git branch | grep -v 'master' | xargs git branch -D'
# alias delete_remote_branch='git push -d origin'
alias delete_remote_branch='git push -d origin ${1:-$(git symbolic-ref --short HEAD)}'

# Tmux
alias t=tmux
alias ta='tmux attach'

# Invoker
alias i=invoker
alias is=invoker start invoker.ini

# Docker
alias d='docker'
alias dc='docker compose'
alias dcb='docker compose build'
alias dcup='docker compose up'
alias dcupd='docker compose up -d'

# Ruby
alias gem_build='~/repos/dotfiles/scripts/gem_build'
alias gem_publish='~/repos/dotfiles/scripts/gem_publish'

# Bundler
alias b=bundle
alias be='bundle exec'
alias bes='bundle exec spring'
alias bi='bundle install'
alias bivb='bundle install --path vendor/bundle'
alias bs='bundle show'
alias bcd='bundle-cd'
alias bo='bundle open'

# Rails
alias rs="bundle exec rails server"
alias rc="bundle exec rails console"
alias run_migrations='bundle exec rake db:migrate'
alias revert_last_migration='bundle exec rake db:rollback STEP=1'
alias dbschema='less db/schema.rb'
# https://github.com/mperham/sidekiq/wiki/Problems-and-Troubleshooting#my-sidekiq-process-is-crashing-what-do-i-do
alias print_native_gems="bundle exec ruby -e 'puts Gem.loaded_specs.values.select { |i| !i.extensions.empty? }.map { |i| i.name }'"

# RSpec
alias r='bundle exec rspec'
alias rd='bundle exec rspec --format documentation'
alias sr='bundle exec spring rspec'
alias s='bundle exec spring'
alias ss='bundle exec spring stop'

# Yarn
alias y="yarn"
alias yi="yarn install"

# Jest
alias j="jest"
alias ju="jest -u"

# Storybook
alias sb="npm run storybook"

# Ansible
# alias an=ansible
# alias anp=ansible-playbook

# Kubernetes
alias k='kubectl'
alias kc='kubectl'
alias kcc='kubectl config current-context'

# Terraform
alias tf='terraform'
alias tff='terraform format'
alias tfv='terraform validate'
alias tfa='terraform apply'

# Heroku
alias h='heroku'
