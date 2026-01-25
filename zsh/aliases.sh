alias l=ls
alias diff=colordiff
alias x=exit

for alias_file in ~/repos/dotfiles/zsh/aliases/*-aliases.sh; do
  source "$alias_file"
done
