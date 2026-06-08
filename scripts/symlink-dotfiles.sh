#!/usr/bin/env bash

set -euo pipefail

dotfiles_dir="${DOTFILES_DIR:-$HOME/repos/dotfiles}"

for source in "$dotfiles_dir"/*; do
  name="$(basename "$source")"

  case "$name" in
    README.md|scripts|hooks)
      continue
      ;;
  esac

  target_name="$name"
  if [ "$name" != "Brewfile" ]; then
    target_name=".$name"
  fi

  ln -sfn "$source" "$HOME/$target_name"
done
