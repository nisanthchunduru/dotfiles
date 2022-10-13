# dotfiles

My dotfiles

## Installation

Install homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install zsh

```
brew install zsh
```

Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Install [rcm](https://github.com/thoughtbot/rcm). rcm is a tool for managing dotfiles from ThoughtBot.

```
brew tap thoughtbot/formulae
brew install rcm
```

Clone the repo

```
mkdir -p ~/repos
git clone --recurse-submodules git@github.com:nisanth074/dotfiles.git ~/repos/dotfiles
```

Symlink the dotfiles

```
rcup -d ~/repos/dotfiles -K
```

Please note that the command above doesn't run the [hooks/post-up](https://github.com/nisanth074/dotfiles/blob/master/hooks/post-up) script which configures OS X to my liking. If you'd like the post-up hook script to be run, run the command below instead

```
rcup -d ~/repos/dotfiles
```
