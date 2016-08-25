# Reset oh-my-zsh
ZSH_THEME_GIT_PROMPT_DIRTY=''

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[red]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

PROMPT='%~`git_prompt_info`%# '
