alias l=ls
alias diff=colordiff
alias x=exit

for alias_file in "$ZSH_DIR"/aliases/*-aliases.sh; do
  source "$alias_file"
done
