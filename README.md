# dotfiles

My dotfiles

## Installation

Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Install [rcm](https://github.com/thoughtbot/rcm)

```
brew tap thoughtbot/formulae
brew install rcm
```

Run

```
git clone git@github.com:nisanth074/dotfiles.git ~/.dotfiles
rcup -C -d ~/.dotfiles/
```