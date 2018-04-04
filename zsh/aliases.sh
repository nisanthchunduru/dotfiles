# Zsh
alias reload='source ~/.zshrc'

alias symlink_dotfiles='rcup -d ~/.dotfiles/ -K'

alias l=ls
alias diff=colordiff
alias cask='brew cask'
alias pub='cat ~/.ssh/id_rsa.pub | tee >(pbcopy)' # Print ssh public key

# Git
alias g=git
alias gs='git status'
alias gcl='git clone'
alias gb='git branch --sort=-creatordate'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcop='git checkout -' # Checkout to previous git branch
alias gc='git commit'
alias gl='git log'
alias gcp='git cherry-pick'
alias gri='git rebase -i'
alias gf='git fetch'
alias grm='git rm'

# Bundler
alias b=bundle
alias be='bundle exec'
alias bi='bundle install --path vendor/bundle'
alias bs='bundle show'
alias bcd='bundle-cd'
alias bo='EDITOR=atom bundle open'

# Rails
alias r='bundle exec rspec'
alias run_migrations='bundle exec rake db:migrate'
alias revert_last_migration='bundle exec rake db:rollback STEP=1'
alias dbschema='less db/schema.rb'
# https://github.com/mperham/sidekiq/wiki/Problems-and-Troubleshooting#my-sidekiq-process-is-crashing-what-do-i-do
alias print_native_gems="bundle exec ruby -e 'puts Gem.loaded_specs.values.select{ |i| !i.extensions.empty? }.map{ |i| i.name }'"

alias invoker='NOEXEC_DISABLE=1 rvm default do invoker'
alias rerun='NOEXEC_DISABLE=1 rvm default do rerun'

# Ansible
# alias an=ansible
# alias anp=ansible-playbook

# Homebrew
alias bb='brew bundle --global'

# Applications
alias sourcetree='open -a SourceTree'
alias macdown='open -a MacDown'
alias st=sourcetree .
alias typora='open -a Typora'

# DNS
alias use_google_dns='networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4'
alias use_cloudflare_dns='networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1'
alias use_adguard_dns='networksetup -setdnsservers Wi-Fi 176.103.130.130 176.103.130.131'

