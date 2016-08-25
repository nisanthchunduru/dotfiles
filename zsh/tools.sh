# autoload -Uz compinit && compinit
# . ~/builds/z/z.sh
. `brew --prefix`/etc/profile.d/z.sh

# Add RVM to PATH for scripting
export PATH=$PATH:$HOME/.rvm/bin

source ~/.nvm/nvm.sh
# [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
# export PATH=./node_modules/.bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR JENV TO WORK!!!
# [[ -s "/Users/nisanth/.jenv/bin/jenv-init.sh" ]] && source "/Users/nisanth/.jenv/bin/jenv-init.sh" && source "/Users/nisanth/.jenv/commands/completion.sh"

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"

export PYTHONPATH=~/Library/Python/2.7/lib/python/site-packages
export PATH=$PATH:~/Library/Python/2.7/bin

export QWANDRY_EDITOR=atom
export ATOM_PATH=~/Applications

# direnv
# eval "$(direnv hook zsh)"
# export DIRENV_LOG_FORMAT=""

# if [ -f "$HOME/.ruby/load_pry.rb" ]; then
#   RUBYLIB="$HOME/.ruby"
#   RUBYOPT="-r load_pry"
#   export RUBYLIB RUBYOPT
# fi
