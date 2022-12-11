# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

#
# zsh-history-substring-search
#
zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

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
source $DOTFILES/private_dotfiles/zsh/aliases.sh
source $ZSH_HOME/tools.sh

# http://unix.stackexchange.com/questions/6620/how-to-edit-command-line-in-full-screen-editor-in-zsh
autoload edit-command-line
zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

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

# Emacs mode
bindkey -e

# Vim mode
# bindkey -v
# bindkey '^R' history-incremental-search-backward

# export DIRENV_LOG_FORMAT=
# eval "$(direnv hook zsh)"

source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.p10k.zsh
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
