# Reset oh-my-zsh
ZSH_THEME_GIT_PROMPT_DIRTY=''

# ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[red]%}("
# ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[red]%}["
# ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"

autoload -U colors && colors

function git_branch_info {
  if [ -d ".git" ]; then
    echo " %{$fg[red]%}[`git rev-parse --abbrev-ref HEAD`]%{$reset_color%}"
  fi
}

PROMPT="%~%{$fg[red]%}%{$reset_color%}\$(git_branch_info)%# "
