# Ruby
alias gem-build='~/repos/dotfiles/scripts/gem_build'
alias gem-publish='~/repos/dotfiles/scripts/gem_publish'

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
alias run-migrations='bundle exec rake db:migrate'
alias revert-last-migration='bundle exec rake db:rollback STEP=1'
alias dbschema='less db/schema.rb'
# https://github.com/mperham/sidekiq/wiki/Problems-and-Troubleshooting#my-sidekiq-process-is-crashing-what-do-i-do
alias print-native-gems="bundle exec ruby -e 'puts Gem.loaded_specs.values.select { |i| !i.extensions.empty? }.map { |i| i.name }'"

# RSpec
alias r='bundle exec rspec'
alias rd='bundle exec rspec --format documentation'
alias sr='bundle exec spring rspec'
alias s='bundle exec spring'
alias ss='bundle exec spring stop'
