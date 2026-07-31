#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./install.sh [--force] [destination_dir]

Examples:
  ./install.sh ~/repos/my-mac-app/MyMacApp
  ./install.sh --force ~/repos/my-mac-app/MyMacApp

Behavior:
  - Copies ACControlIntents.swift into destination_dir
  - Defaults destination_dir to the current directory
  - Refuses to overwrite unless --force is provided
EOF
}

force=false
destination_dir="$PWD"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--force)
      force=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      destination_dir="$1"
      shift
      ;;
  esac
done

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$script_dir/ACControlIntents.swift"
destination_dir="${destination_dir/#\~/$HOME}"
destination_file="$destination_dir/ACControlIntents.swift"
default_ac_script="$HOME/repos/dotfiles/scripts/samsung_ac.rb"

if [[ ! -f "$source_file" ]]; then
  echo "Error: source file not found: $source_file" >&2
  exit 1
fi

if [[ ! -d "$destination_dir" ]]; then
  echo "Error: destination directory does not exist: $destination_dir" >&2
  exit 1
fi

if [[ -f "$destination_file" && "$force" != true ]]; then
  echo "Error: $destination_file already exists."
  echo "Use --force to overwrite."
  exit 1
fi

cp -f "$source_file" "$destination_file"

echo "Installed:"
echo "  $destination_file"
echo
if [[ -f "$default_ac_script" ]]; then
  echo "Confirmed AC control script path:"
  echo "  $default_ac_script"
else
  echo "Warning: default AC control script was not found at:"
  echo "  $default_ac_script"
  echo "Set 'ac_script_path' in your app if your dotfiles live elsewhere."
fi
echo
echo "Next steps:"
echo "1. In Xcode, ensure ACControlIntents.swift is added to your macOS app target."
echo "2. In app startup, call: ACAppShortcutsProvider.updateAppShortcutParameters()"
echo "3. Build and run once, then open Shortcuts and search for:"
echo "   - Turn On AC"
echo "   - Turn Off AC"
echo "   - Set AC Temperature"
