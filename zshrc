export DOTFILES=~/repos/dotfiles

export ZSH_HOME=~/.zsh
export PATH="$HOME/bin:$PATH"

# export EDITOR='vim'
# export EDITOR='nvim'
export EDITOR='code'

# Emacs mode
bindkey -e

# Vim mode
# bindkey -v
# bindkey '^R' history-incremental-search-backward

setopt extendedglob

# for file ($ZSH_HOME/^.zshrc) source $file
# for file ($ZSH_HOME/^.zshrc) do
#   filename=`basename $file`
#   if [[ $filename == ",zshrc" ]] then
#     continue
#   fi
#
#   source $file
# done
source $ZSH_HOME/oh-my-zsh.sh
unalias gpu
source $ZSH_HOME/prompt.sh
source $ZSH_HOME/aliases.sh
source $DOTFILES/private_dotfiles/zsh/aliases.sh
source $ZSH_HOME/tools.sh

# http://unix.stackexchange.com/questions/6620/how-to-edit-command-line-in-full-screen-editor-in-zsh
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Borrowed from https://stackoverflow.com/questions/68351594/rvm-install-ruby-2-6-4-fails-with-makefile-error-implicit-declaration-of-functi
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"

# Load NVM
export NVM_DIR="/Users/nisanth/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Borrowed from https://medium.com/@kinduff/automatic-version-switch-for-nvm-ff9e00ae67f3
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc ]]; then
    nvm use --silent
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# [ -s ".nvmrc" ] && nvm use `cat .nvmrc` --silent

# Load NVM bash completions
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="./node_modules/.bin:$PATH"

# Load functions
fpath=($ZSH_HOME/functions $fpath)

# for file ($ZSH_HOME/functions/*) autoload -Uz $(basename $file)
for file ($ZSH_HOME/functions/*~*\.disabled); do
  function_name=$(basename $file)
  autoload -Uz $function_name
done

# fpath=($ZSH_HOME/completions $fpath)

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source # "$HOME/.iterm2_shell_integration.zsh"

if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
  source "$HOME/.iterm2_shell_integration.zsh"

  iterm2_set_user_var rubyVersion $(rvm current)
  iterm2_set_user_var nodeVersion "node $(nvm current)"
fi

[[ -d ~/.pgenv ]] && export PATH="$HOME/.pgenv/bin:$HOME/.pgenv/pgsql/bin:$PATH"
