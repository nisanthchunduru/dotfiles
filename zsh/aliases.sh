alias l=ls

alias g=git
alias gs='git status'
alias gcl='git clone'
# alias gb='git branch'
alias gb='git branch --sort=-creatordate'
alias gco='git checkout'
alias gc='git commit'
alias gl='git log'
alias gpu='git push'
alias gpl='git pull'
alias gcp='git cherry-pick'
alias gri='git rebase -i'

alias x=extract
alias diff=colordiff
alias cask='brew cask'
alias r=rvm

alias b=bundle
alias be='bundle exec'
alias bi='bundle install --path vendor/bundle'
alias bs='bundle show'
alias bcd='bundle-cd'
alias bo='EDITOR=atom bundle open'

alias run_migrations='bundle exec rake db:migrate'
alias revert_migration='bundle exec rake db:rollback STEP=1'

alias invoker='NOEXEC_DISABLE=1 rvm default do invoker'
alias rerun='NOEXEC_DISABLE=1 rvm default do rerun'

alias pub='cat ~/.ssh/id_rsa.pub | tee >(pbcopy)'

# alias an=ansible
# alias anp=ansible-playbook
alias sourcetree='open -a SourceTree'
alias macdown='open -a MacDown'
alias st=sourcetree .
alias typora='open -a Typora'

alias use_google_dns='networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4'
alias use_adguard_dns='networksetup -setdnsservers Wi-Fi 176.103.130.130 176.103.130.131'

# https://github.com/mperham/sidekiq/wiki/Problems-and-Troubleshooting#my-sidekiq-process-is-crashing-what-do-i-do
alias print_native_gems="bundle exec ruby -e 'puts Gem.loaded_specs.values.select{ |i| !i.extensions.empty? }.map{ |i| i.name }'"
