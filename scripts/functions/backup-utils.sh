backup_path() {
  local path="${1}"

  if path_exists "${path}.orig"; then
    remove_path "${path}.orig"
  fi

  mv "${path}" "${path}.orig"
}
