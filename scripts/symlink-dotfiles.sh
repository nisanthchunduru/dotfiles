#!/usr/bin/env bash

set -euo pipefail

dotfiles_dir="${DOTFILES_DIR:-${HOME}/repos/dotfiles}"
scripts_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

source "${scripts_dir}/functions/path-utils.sh"
source "${scripts_dir}/functions/backup-utils.sh"
source "${scripts_dir}/functions/legacy-zsh-installation-migration.sh"

install_symlink() {
  local source="${1}"
  local target="${2}"
  local resolved_source

  resolved_source="$(cd "$(dirname "${source}")" && pwd -P)/$(basename "${source}")"

  if [ -L "${target}" ] &&
    [ "$(resolved_link_target "${target}")" = "${resolved_source}" ]; then
    return 0
  fi

  if path_exists "${target}"; then
    backup_path "${target}"
  fi
  ln -s "${source}" "${target}"
}

migrate_legacy_zsh_installation

for source in "${dotfiles_dir}"/*; do
  name="$(basename "${source}")"

  case "${name}" in
    README.md|setup.sh|scripts|hooks|zsh)
      continue
      ;;
  esac

  target_name="${name}"
  if [ "${name}" != "Brewfile" ]; then
    target_name=".${name}"
  fi

  install_symlink "${source}" "${HOME}/${target_name}"
done
