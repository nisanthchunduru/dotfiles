# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES=~/repos/dotfiles

export ZSH_HOME=~/.zsh
export PATH="$HOME/bin:$PATH"

# export EDITOR='vim'
# export EDITOR='nvim'
export EDITOR='code'

setopt extendedglob

# export ZPLUG_HOME=/opt/homebrew/opt/zplug
# source $ZPLUG_HOME/init.zsh

# zplug "chrisands/zsh-yarn-completions", defer:2
# zplug "chrisands/zsh-yarn-completions"

# for file ($ZSH_HOME/^.zshrc) source $file
# for file ($ZSH_HOME/^.zshrc) do
#   filename=`basename $file`
#   if [[ $filename == ",zshrc" ]] then
#     continue
#   fi
#
#   source $file
# done
# source $ZSH_HOME/oh-my-zsh.sh
# unalias gpu
source $ZSH_HOME/prompt.sh
source $ZSH_HOME/aliases.sh
source $ZSH_HOME/tools.sh

# http://unix.stackexchange.com/questions/6620/how-to-edit-command-line-in-full-screen-editor-in-zsh
autoload edit-command-line
zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

export PATH="./node_modules/.bin:$PATH"

# Add my functions to fpath
fpath=($ZSH_HOME/functions $fpath)

# fpath=($ZSH_HOME/completions $fpath)

# Load my functions
# for file ($ZSH_HOME/functions/*) autoload -Uz $(basename $file)
for file ($ZSH_HOME/functions/*~*\.disabled); do
  function_name=$(basename $file)
  autoload -Uz $function_name
done

# Source iTerm 2 shell integration
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source # "$HOME/.iterm2_shell_integration.zsh"
if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
  source "$HOME/.iterm2_shell_integration.zsh"

  # iterm2_set_user_var rubyVersion $(rvm current)
  # iterm2_set_user_var nodeVersion "node $(nvm current)"
fi

# Turn on Emacs mode
bindkey -e

# Turn on Vim mode
# bindkey -v
# bindkey '^R' history-incremental-search-backward

# export DIRENV_LOG_FORMAT=
# eval "$(direnv hook zsh)"

# source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
source $(brew --prefix)/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.p10k.zsh
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

if [ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

if type mise &>/dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  eval "$(mise activate zsh)"
fi
