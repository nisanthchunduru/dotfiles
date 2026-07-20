resolved_link_target() {
  local link="${1}"
  local target
  local target_parent

  target="$(readlink "${link}")"
  if [[ "${target}" != /* ]]; then
    target="$(dirname "${link}")/${target}"
  fi

  target_parent="$(dirname "${target}")"
  if [ -d "${target_parent}" ]; then
    printf '%s/%s\n' "$(cd "${target_parent}" && pwd -P)" "$(basename "${target}")"
  else
    printf '%s\n' "${target}"
  fi
}

path_exists() {
  [ -e "${1}" ] || [ -L "${1}" ]
}

remove_path() {
  local path="${1}"

  if [ -d "${path}" ] && [ ! -L "${path}" ]; then
    find "${path}" -depth -delete
  else
    rm "${path}"
  fi
}
