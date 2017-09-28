# Reset oh-my-zsh
ZSH_THEME_GIT_PROMPT_DIRTY=''

# ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[red]%}("
# ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[red]%}["
# ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"

# PROMPT="%~`git_prompt_info`%# "
# PROMPT="%~`git_prompt_info` %{$fg[red]%}[`~/.rvm/bin/rvm-prompt`]%{$reset_color%}%# "
# PROMPT="%~ %{$fg[red]%}[`git rev-parse --abbrev-ref HEAD`]%{$reset_color%} %{$fg[red]%}[`~/.rvm/bin/rvm-prompt`]%{$reset_color%}%# "

autoload -U colors && colors
function git_branch_info {
  if [ -d ".git" ]; then
    echo " %{$fg[red]%}[`git rev-parse --abbrev-ref HEAD`]%{$reset_color%}"
  fi
}
function ruby_version_info {
  rvm_prompt_output=`rvm current`

  if [ $rvm_prompt_output = "system" ]; then
    rvm_prompt_output="ruby-system"
  fi
  # sed "s/ruby-/r-/g" <<<"$rvm_prompt_output"
  echo ${rvm_prompt_output/ruby-/r-}
}
# setopt prompt_subst
# PROMPT="%~\$(git_branch_info) %{$fg[red]%}[\$(rvm-prompt)]%{$reset_color%}%# "
PROMPT="%~ %{$fg[red]%}[\$(ruby_version_info)]%{$reset_color%}\$(git_branch_info)%# "
