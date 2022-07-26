# Load RVM into a shell session *as a function*

# export RBENV_ROOT=$HOME/builds/rbenv
# export PATH=$RBENV_ROOT/bin:$PATH
# eval "$(rbenv init -)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# source /Users/nisanth/.pgvm/pgvm_env
[[ -d ~/.pgvm ]] && source /Users/nisanth/.pgvm/pgvm_env

[[ -d ~/.pgenv ]] && export PATH="$HOME/.pgenv/bin:$HOME/.pgenv/pgsql/bin:$PATH"
