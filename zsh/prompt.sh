# Lightweight prompt with async Git status.
#
# Renders like:
#   ~/repos/dotfiles master*
#
# Git state is computed after the prompt appears, then zle refreshes the prompt
# when the background process returns.

setopt prompt_subst

autoload -Uz add-zsh-hook

typeset -g ZSH_GIT_PROMPT=''
typeset -g _ZSH_GIT_PROMPT_FD=''
typeset -g _ZSH_GIT_PROMPT_CWD=''

PROMPT='%~${ZSH_GIT_PROMPT} '

function _zsh_git_prompt_close_fd {
  emulate -L zsh

  local fd=$_ZSH_GIT_PROMPT_FD
  [[ -n $fd ]] || return

  zle -F $fd 2>/dev/null
  exec {fd}<&- 2>/dev/null
  _ZSH_GIT_PROMPT_FD=''
}

function _zsh_git_prompt_done {
  emulate -L zsh

  local fd=$1
  local prompt_segment=''

  if IFS= read -r prompt_segment <&$fd; then
    if [[ $PWD == $_ZSH_GIT_PROMPT_CWD ]]; then
      ZSH_GIT_PROMPT=$prompt_segment
    fi
  fi

  if [[ $_ZSH_GIT_PROMPT_FD == $fd ]]; then
    _zsh_git_prompt_close_fd
  else
    zle -F $fd 2>/dev/null
    exec {fd}<&- 2>/dev/null
  fi

  zle reset-prompt 2>/dev/null
}

function _zsh_git_prompt_start {
  emulate -L zsh

  [[ -o interactive ]] || return

  _zsh_git_prompt_close_fd
  _ZSH_GIT_PROMPT_CWD=$PWD

  exec {_ZSH_GIT_PROMPT_FD}< <(
    emulate -L zsh

    local branch=''
    local dirty=''

    command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

    branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null)
    if [[ -z $branch ]]; then
      branch=$(command git rev-parse --short HEAD 2>/dev/null) || exit 0
    fi

    if [[ -n $(command git status --porcelain --untracked-files=normal 2>/dev/null) ]]; then
      dirty='*'
    fi

    print -r -- " ${branch}${dirty}"
  )

  zle -F $_ZSH_GIT_PROMPT_FD _zsh_git_prompt_done 2>/dev/null || _zsh_git_prompt_close_fd
}

function _zsh_git_prompt_precmd {
  emulate -L zsh

  if [[ $PWD != $_ZSH_GIT_PROMPT_CWD ]]; then
    ZSH_GIT_PROMPT=''
  fi

  _zsh_git_prompt_start
}

function _zsh_git_prompt_chpwd {
  ZSH_GIT_PROMPT=''
}

add-zsh-hook precmd _zsh_git_prompt_precmd
add-zsh-hook chpwd _zsh_git_prompt_chpwd
