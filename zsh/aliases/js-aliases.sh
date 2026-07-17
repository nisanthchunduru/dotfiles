# NPM
npm-upgrade-global-packages() {
  local root pkgs=() name dir
  root=$(npm root -g 2>/dev/null) || return 1

  while IFS= read -r name; do
    [[ -z "$name" ]] && continue
    case "$name" in
      npm|corepack) continue ;;
    esac
    dir="$root/$name"
    [[ -f "$dir/package.json" ]] || continue
    pkgs+=("$name")
  done < <(npm ls -g --depth=0 --parseable 2>/dev/null | tail -n +2 | sed 's#.*/node_modules/##')

  if (( ${#pkgs[@]} == 0 )); then
    echo "No global npm packages to upgrade."
    return 0
  fi

  echo "Upgrading global npm packages:"
  printf '  - %s\n' "${pkgs[@]}"
  npm install -g "${pkgs[@]/%/@latest}"
}

# Yarn
alias y="yarn"
alias yi="yarn install"

# Jest
alias j="jest"
alias ju="jest -u"

# Storybook
alias sb="npm run storybook"
