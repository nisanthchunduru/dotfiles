# Load Oh My Zsh
source ~/.zsh/oh-my-zsh.sh

MY_ZSH=~/.zsh

setopt extendedglob

for file ($MY_ZSH/^oh-my-zsh.sh) source $file
for file ($MY_ZSH/SupportBee/*) source $file

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Load NVM
export NVM_DIR="/Users/nisanth/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
