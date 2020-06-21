export ZSH_HOME=~/.zsh
export PATH="$HOME/bin:$PATH"

export EDITOR='vim'
# export EDITOR='nvim'

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
source ~/.dotfiles/private_dotfiles/zsh/aliases.sh
source $ZSH_HOME/tools.sh

# http://unix.stackexchange.com/questions/6620/how-to-edit-command-line-in-full-screen-editor-in-zsh
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Load NVM
export NVM_DIR="/Users/nisanth/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Load NVM bash completions

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load functions
fpath=($ZSH_HOME/functions $fpath)
# for file ($ZSH_HOME/functions/*) autoload -Uz $(basename $file)
for file ($ZSH_HOME/functions/*~*\.disabled); do
  function_name=$(basename $file)
  autoload -Uz $function_name
done

# fpath=($ZSH_HOME/completions $fpath)

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [ -z $ITERM_SESSION_ID ]; then
  if [ -f "${HOME}/.iterm2_shell_integration.zsh" ]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
    
    iterm2_print_user_vars () {
      iterm2_set_user_var rubyVersion `rvm current`
      iterm2_set_user_var nodeVersion "node $(nvm current)"
    }
  fi
fi
