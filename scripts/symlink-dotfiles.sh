#!/usr/bin/env bash

set -euo pipefail

dotfiles_dir="${DOTFILES_DIR:-$HOME/repos/dotfiles}"
zsh_source_dir="$(cd "$dotfiles_dir/zsh" && pwd -P)"

resolved_link_target() {
  local link="$1"
  local target
  local target_parent

  target="$(readlink "$link")"
  if [[ "$target" != /* ]]; then
    target="$(dirname "$link")/$target"
  fi

  target_parent="$(dirname "$target")"
  if [ -d "$target_parent" ]; then
    printf '%s/%s\n' "$(cd "$target_parent" && pwd -P)" "$(basename "$target")"
  else
    printf '%s\n' "$target"
  fi
}

points_to_zsh_source() {
  local target

  target="$(resolved_link_target "$1")"
  [[ "$target" == "$zsh_source_dir" || "$target" == "$zsh_source_dir/"* ]]
}

migrate_legacy_zsh_installation() {
  local legacy_zsh_dir="$HOME/.zsh"
  local link
  local parent_dir
  local removed=0

  if [ -L "$legacy_zsh_dir" ]; then
    if points_to_zsh_source "$legacy_zsh_dir"; then
      rm "$legacy_zsh_dir"
      echo "Removed legacy symlink: $legacy_zsh_dir"
    fi
    return
  fi

  [ -d "$legacy_zsh_dir" ] || return

  while IFS= read -r link; do
    if points_to_zsh_source "$link"; then
      rm "$link"
      echo "Removed legacy symlink: $link"
      removed=$((removed + 1))

      parent_dir="$(dirname "$link")"
      while [[ "$parent_dir" == "$legacy_zsh_dir/"* ]]; do
        rmdir "$parent_dir" 2>/dev/null || break
        parent_dir="$(dirname "$parent_dir")"
      done
    fi
  done < <(find "$legacy_zsh_dir" -type l -print)

  if [ "$removed" -gt 0 ]; then
    rmdir "$legacy_zsh_dir" 2>/dev/null || true
  fi
}

migrate_legacy_zsh_installation

for source in "$dotfiles_dir"/*; do
  name="$(basename "$source")"

  case "$name" in
    README.md|scripts|hooks|zsh)
      continue
      ;;
  esac

  target_name="$name"
  if [ "$name" != "Brewfile" ]; then
    target_name=".$name"
  fi

  ln -sfn "$source" "$HOME/$target_name"
done
