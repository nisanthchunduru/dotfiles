#!/usr/bin/env bash

set -euo pipefail

BASE_URL="https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes"
API_URL="https://api.github.com/repos/mbadolato/iTerm2-Color-Schemes/contents/schemes"
ITERM_PRESETS_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
CUSTOM_PRESETS_PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"

usage() {
    echo "Usage: $(basename "$0") <command> [options] [scheme-name-or-pattern ...]"
    echo
    echo "Commands:"
    echo "  install    Install color scheme(s)"
    echo "  uninstall  Uninstall color scheme(s)"
    echo
    echo "Options:"
    echo "  --all      Apply to all available schemes"
    echo
    echo "Arguments can be exact names or glob patterns (*, ?, [)."
    echo
    echo "Examples:"
    echo "  $(basename "$0") install Dracula"
    echo "  $(basename "$0") install \"Solarized*\""
    echo "  $(basename "$0") install \"*Dark*\""
    echo "  $(basename "$0") install --all"
    echo "  $(basename "$0") uninstall \"Solarized Dark\""
    echo "  $(basename "$0") uninstall \"Nord*\""
    echo "  $(basename "$0") uninstall --all"
    exit 1
}

fetch_all_scheme_names() {
    curl -s "$API_URL" | jq -r '.[] | select(.name | endswith(".itermcolors")) | .name | rtrimstr(".itermcolors")'
}

is_glob_pattern() {
    [[ "$1" == *'*'* || "$1" == *'?'* || "$1" == *'['* ]]
}

filter_schemes_by_pattern() {
    local pattern="$1"
    local schemes
    schemes=$(fetch_all_scheme_names)
    if [[ -z "$schemes" ]]; then
        echo "Error: Failed to fetch scheme list" >&2
        return 1
    fi

    while IFS= read -r name; do
        # shellcheck disable=SC2254
        case "$name" in
            $pattern) echo "$name" ;;
        esac
    done <<< "$schemes"
}

install_schemes() {
    local arg="$1"
    if is_glob_pattern "$arg"; then
        local matches
        matches=$(filter_schemes_by_pattern "$arg")
        if [[ -z "$matches" ]]; then
            echo "No schemes matched pattern \"$arg\"" >&2
            return 1
        fi
        while IFS= read -r name; do
            install_scheme "$name"
        done <<< "$matches"
    else
        install_scheme "$arg"
    fi
}

uninstall_schemes() {
    local arg="$1"
    if is_glob_pattern "$arg"; then
        local matches
        matches=$(filter_schemes_by_pattern "$arg")
        if [[ -z "$matches" ]]; then
            echo "No schemes matched pattern \"$arg\"" >&2
            return 1
        fi
        while IFS= read -r name; do
            uninstall_scheme "$name"
        done <<< "$matches"
    else
        uninstall_scheme "$arg"
    fi
}

install_scheme() {
    local name="$1"
    local encoded_name
    encoded_name=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$name'''))")
    local url="${BASE_URL}/${encoded_name}.itermcolors"

    echo "Installing \"$name\" iTerm Color Theme"

    local tmpdir="/tmp/iterm-color-schemes"
    mkdir -p "$tmpdir"
    local tmpfile="${tmpdir}/${name}.itermcolors"

    if ! curl -sf "$url" -o "$tmpfile"; then
        echo "Error: Failed to download color scheme \"$name\"" >&2
        return 1
    fi

    /usr/libexec/PlistBuddy -c "Add ':Custom Color Presets:$name' dict" "$CUSTOM_PRESETS_PLIST" 2>/dev/null || true
    /usr/libexec/PlistBuddy -c "Merge '$tmpfile' ':Custom Color Presets:$name'" "$CUSTOM_PRESETS_PLIST"
    echo "✔ Installed \"$name\" iTerm Color Theme"
}

install_all_schemes() {
    local schemes
    schemes=$(fetch_all_scheme_names)
    if [[ -z "$schemes" ]]; then
        echo "Error: Failed to fetch scheme list" >&2
        exit 1
    fi

    while IFS= read -r name; do
        install_scheme "$name"
    done <<< "$schemes"
}

get_installed_presets() {
    /usr/libexec/PlistBuddy -c "Print ':Custom Color Presets'" "$CUSTOM_PRESETS_PLIST" 2>/dev/null | grep "^    [^ ]" | sed 's/^    //' | sed 's/ =$//'
}

uninstall_scheme() {
    local name="$1"
    echo "Uninstalling \"$name\" iTerm Color Theme"

    if /usr/libexec/PlistBuddy -c "Delete ':Custom Color Presets:$name'" "$CUSTOM_PRESETS_PLIST" 2>/dev/null; then
        echo "✔ Uninstalled \"$name\" iTerm Color Theme"
    else
        echo "Warning: Color scheme \"$name\" not found or already uninstalled" >&2
    fi
}

uninstall_all_schemes() {
    local schemes
    schemes=$(fetch_all_scheme_names)
    if [[ -z "$schemes" ]]; then
        echo "Error: Failed to fetch scheme list" >&2
        exit 1
    fi

    while IFS= read -r name; do
        uninstall_scheme "$name"
    done <<< "$schemes"
}

[[ $# -lt 1 ]] && usage

command="$1"
shift

case "$command" in
    install)
        if [[ $# -eq 0 ]]; then
            echo "Error: No scheme name provided" >&2
            usage
        elif [[ "$1" == "--all" ]]; then
            install_all_schemes
        else
            for arg in "$@"; do
                install_schemes "$arg"
            done
        fi
        ;;
    uninstall)
        if [[ $# -eq 0 ]]; then
            echo "Error: No scheme name provided" >&2
            usage
        elif [[ "$1" == "--all" ]]; then
            uninstall_all_schemes
        else
            for arg in "$@"; do
                uninstall_schemes "$arg"
            done
        fi
        ;;
    *)
        echo "Error: Unknown command \"$command\"" >&2
        usage
        ;;
esac
