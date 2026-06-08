autoload -U colors && colors

setopt prompt_subst

function git_branch_info {
  command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

  local branch=''
  local dirty=''

  branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null)
  if [[ -z $branch ]]; then
    branch=$(command git rev-parse --short HEAD 2>/dev/null) || return
  fi

  if [[ -n $(command git status --porcelain --untracked-files=normal 2>/dev/null) ]]; then
    dirty='*'
  fi

  print -r -- " %{$fg[red]%}[${branch}${dirty}]%{$reset_color%}"
}

PROMPT='%~$(git_branch_info)%# '
