# Install homebrew (unless already installed)
if ! command -v brew &> /dev/null; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Installed homebrew."
fi

echo "Installing asdf..."
brew install asdf
echo "Installed asdf"

echo "Installing z..."
brew install z
echo "Installed z"

echo "Installing powerlevel10k..."
brew install powerlevel10k
echo "Installed powerlevel10k"

echo "Cloning dotfiles repo..."
mkdir -p ~/repos
git clone git@github.com:nisanthchunduru/dotfiles.git ~/repos/dotfiles
echo "Cloned dotfiles repo."

echo "Install vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo Installed vundle"

echo "Installing rcm..."
brew tap thoughtbot/formulae
brew install rcm
echo "Installed rcm"

echo "Symlinking dotfiles..."
rcup -d ~/repos/dotfiles -K
echo "Symlinked dotfiles"
