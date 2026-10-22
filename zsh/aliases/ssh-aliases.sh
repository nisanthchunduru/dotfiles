alias pub='cat ~/.ssh/id_rsa.pub | tee >(pbcopy)' # Print ssh public key

alias rugged-ssh="autossh -M 0 -o ServerAliveInterval=30 -o ServerAliveCountMax=3 -t user@host 'tmux new-session -A -s main'"
