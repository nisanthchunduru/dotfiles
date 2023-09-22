# Install homebrew (unless already installed)
if ! command -v brew &> /dev/null; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Installed homebrew."
fi

echo "Cloning dotfiles repo..."
mkdir -p ~/repos
git clone git@github.com:nisanthchunduru/dotfiles.git ~/repos/dotfiles
echo "Cloned dotfiles repo."

echo "Installing rcm..."
brew tap thoughtbot/formulae
brew install rcm
echo "Installed rcm"

echo "Symlinking dotfiles..."
rcup -d ~/repos/dotfiles -K
echo "Symlinked dotfiles"