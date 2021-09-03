# Zsh
alias reload='source ~/.zshrc'
alias symlink_dotfiles='rcup -d ~/.dotfiles/ -K'

alias l=ls
alias diff=colordiff
alias cask='brew cask'
alias pub='cat ~/.ssh/id_rsa.pub | tee >(pbcopy)' # Print ssh public key
alias sub='subdb d'
alias strip_location_information="ruby ~/repos/dotfiles/scripts/strip_location_information.rb"

# Homebrew
alias bb='brew bundle --global'
alias ibrew='arch -x86_64 /usr/local/bin/brew'

# Applications
alias sourcetree='open -a SourceTree'
alias macdown='open -a MacDown'
alias st=sourcetree .
alias typora='open -a Typora'

# DNS
alias use_google_dns='networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4'
alias use_cloudflare_dns='networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1'
alias use_adguard_dns='networksetup -setdnsservers Wi-Fi 176.103.130.130 176.103.130.131'
alias use_local_dns='networksetup -setdnsservers Wi-Fi 127.0.0.1'

# Git
alias g=git
alias gs='git status'
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
alias grm='git rm'
alias discardchanges='git checkout --'

# Invoker
# alias invoker='NOEXEC_DISABLE=1 rvm default do invoker'
alias i=invoker
alias is=invoker start invoker.ini

# Docker
alias d='docker'
alias dco='docker-compose'
alias db='docker-compose build'
alias dup='docker-compose up'
alias dupd='docker-compose up -d'

# RVM
alias rerun='NOEXEC_DISABLE=1 rvm default do rerun'

# Bundler
alias b=bundle
alias be='bundle exec'
alias bes='bundle exec spring'
alias bi='bundle install'
alias bivb='bundle install --path vendor/bundle'
alias bs='bundle show'
alias bcd='bundle-cd'
alias bo='EDITOR=atom bundle open'

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

# Cucumber
alias c='bundle exec cucumber'

# Heroku
alias h='heroku'

# Ansible
# alias an=ansible
# alias anp=ansible-playbook
