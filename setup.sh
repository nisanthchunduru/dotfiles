#!/usr/bin/env bash

set -euo pipefail

dotfiles_dir="${DOTFILES_DIR:-$HOME/repos/dotfiles}"

ensure_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

ensure_formula() {
  local formula="$1"

  if brew list --formula "$formula" >/dev/null 2>&1; then
    echo "$formula is already installed."
  else
    echo "Installing $formula..."
    brew install "$formula"
  fi
}

ensure_command() {
  local command_name="$1"
  local formula="$2"

  if command -v "$command_name" >/dev/null 2>&1; then
    echo "$command_name is already installed."
  else
    ensure_formula "$formula"
  fi
}

ensure_node() {
  if command -v npm >/dev/null 2>&1; then
    echo "Node.js is already installed."
    return
  fi

  echo "Installing Node.js with mise..."
  mise use --global node@lts
  eval "$(mise activate bash --shims)"
}

ensure_pi() {
  local package="@earendil-works/pi-coding-agent"
  local extension
  local installed_extensions

  if command -v pi >/dev/null 2>&1 &&
    npm list --global --depth=0 "$package" >/dev/null 2>&1; then
    echo "pi is already installed."
  else
    echo "Installing pi..."
    npm install --global --ignore-scripts "$package"
  fi

  installed_extensions="$(pi list 2>/dev/null || true)"
  for extension in npm:pi-mcp-adapter npm:pi-bedrock-mantle; do
    if grep -Fq "$extension" <<<"$installed_extensions"; then
      echo "$extension is already installed."
    else
      echo "Installing $extension..."
      pi install "$extension"
    fi
  done
}

ensure_repository() {
  local name="$1"
  local url="$2"
  local target="$3"

  if [ -d "$target/.git" ]; then
    echo "$name is already installed."
  elif [ -e "$target" ]; then
    echo "Error: $target exists but is not a Git repository." >&2
    return 1
  else
    echo "Installing $name..."
    mkdir -p "$(dirname "$target")"
    git clone "$url" "$target"
  fi
}

ensure_homebrew
ensure_command git git
ensure_command mise mise
ensure_node
ensure_pi
ensure_formula z
ensure_formula powerlevel10k

ensure_repository \
  "dotfiles" \
  "git@github.com:nisanthchunduru/dotfiles.git" \
  "$dotfiles_dir"

ensure_repository \
  "Vundle" \
  "https://github.com/VundleVim/Vundle.vim.git" \
  "$HOME/.vim/bundle/Vundle.vim"

echo "Symlinking dotfiles..."
DOTFILES_DIR="$dotfiles_dir" bash "$dotfiles_dir/scripts/symlink-dotfiles.sh"
echo "Setup complete."
