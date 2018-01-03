# export EDITOR='nvim'
export EDITOR='vim'

# Emacs mode
bindkey -e

# Vim mode
# bindkey -v
# bindkey '^R' history-incremental-search-backward

# http://unix.stackexchange.com/questions/6620/how-to-edit-command-line-in-full-screen-editor-in-zsh
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

fpath=($MY_ZSH/functions $fpath)
# for file ($MY_ZSH/functions/*) autoload -Uz $(basename $file)
for file ($MY_ZSH/functions/*~*\.disabled.sh) autoload -Uz $(basename $file)

# fpath=($MY_ZSH/completions $fpath)
