does_symlink_point_to_zsh_dir_path_or_any_path_inside_zsh_dir() {
  local symlink="${1}"
  local zsh_dir="${2}"
  local target

  target="$(resolved_link_target "${symlink}")"
  [[ "${target}" == "${zsh_dir}" || "${target}" == "${zsh_dir}/"* ]]
}

migrate_legacy_zsh_installation() {
  local legacy_zsh_dir="${HOME}/.zsh"
  local zsh_dir
  local link
  local parent_dir
  local removed=0

  zsh_dir="$(cd "${dotfiles_dir}/zsh" && pwd -P)"

  if [ -L "${legacy_zsh_dir}" ]; then
    if does_symlink_point_to_zsh_dir_path_or_any_path_inside_zsh_dir \
      "${legacy_zsh_dir}" \
      "${zsh_dir}"; then
      rm "${legacy_zsh_dir}"
      echo "Removed legacy symlink: ${legacy_zsh_dir}"
    fi
    return 0
  fi

  [ -d "${legacy_zsh_dir}" ] || return 0

  while IFS= read -r link; do
    if does_symlink_point_to_zsh_dir_path_or_any_path_inside_zsh_dir \
      "${link}" \
      "${zsh_dir}"; then
      rm "${link}"
      echo "Removed legacy symlink: ${link}"
      removed=$((removed + 1))

      parent_dir="$(dirname "${link}")"
      while [[ "${parent_dir}" == "${legacy_zsh_dir}/"* ]]; do
        rmdir "${parent_dir}" 2>/dev/null || break
        parent_dir="$(dirname "${parent_dir}")"
      done
    fi
  done < <(find "${legacy_zsh_dir}" -type l -print)

  if [ "${removed}" -gt 0 ]; then
    rmdir "${legacy_zsh_dir}" 2>/dev/null || true
  fi
}
