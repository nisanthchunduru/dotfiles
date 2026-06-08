# autoload -Uz compinit && compinit
# . ~/builds/z/z.sh
if [ -f /opt/homebrew/etc/profile.d/z.sh ]; then
  . /opt/homebrew/etc/profile.d/z.sh
fi

# export PATH=./node_modules/.bin:$PATH

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
