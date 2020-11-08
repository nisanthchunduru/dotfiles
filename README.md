# dotfiles

My dotfiles

## Installation

Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Install [rcm](https://github.com/thoughtbot/rcm) (rcm is a tool for managing dotfiles from ThoughtBot)

```
brew tap thoughtbot/formulae
brew install rcm
```

Run

```
mkdir -p ~/repos
git clone git@github.com:nisanth074/dotfiles.git ~/repos/dotfiles
rcup -d ~/repos/dotfiles
```
If you wish to only symlink the dotfiles and not run the [hooks/post-up](https://github.com/nisanth074/dotfiles/blob/master/hooks/post-up) script post symlinking, instead run

```
rcup -d ~/repos/dotfiles -K
```
