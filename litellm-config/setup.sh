#!/bin/bash
# LiteLLM LaunchAgent Installer
# Website: https://www.litellm.ai/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLIST_NAME="ai.litellm.plist"
PLIST_TEMPLATE="$SCRIPT_DIR/ai.litellm.plist.template"
PLIST_GENERATED="$SCRIPT_DIR/$PLIST_NAME"
PLIST_TARGET="$HOME/Library/LaunchAgents/$PLIST_NAME"

find_litellm_binary() {
    LITELLM_BIN=$(command -v litellm || echo "")
    if [ -z "$LITELLM_BIN" ]; then
        echo "Error: litellm not found in PATH"
        exit 1
    fi
}

generate_plist() {
    echo "Generating plist from template..."
    sed -e "s|{{LITELLM_BIN}}|$LITELLM_BIN|g" \
        -e "s|{{CONFIG_DIR}}|$SCRIPT_DIR|g" \
        "$PLIST_TEMPLATE" > "$PLIST_GENERATED"
}

ensure_launch_agents_dir() {
    mkdir -p "$HOME/Library/LaunchAgents"
}

unload_existing_service() {
    if launchctl list | grep -q "ai.litellm"; then
        echo "Unloading existing service..."
        launchctl unload "$PLIST_TARGET" 2>/dev/null || true
    fi
}

symlink_plist() {
    echo "Creating symlink: $PLIST_TARGET -> $PLIST_GENERATED"
    ln -sf "$PLIST_GENERATED" "$PLIST_TARGET"
}

load_service() {
    echo "Loading LiteLLM service..."
    launchctl load "$PLIST_TARGET"
}

print_success_message() {
    echo ""
    echo "LiteLLM installed and started successfully!"
    echo ""
    echo "Useful commands:"
    echo "  View status:  launchctl list | grep litellm"
    echo "  View logs:     log show --predicate 'process == \"litellm\"' --last 1h"
    echo "  Stream logs:   log stream --predicate 'process == \"litellm\"'"
    echo "  Stop service:  launchctl unload ~/Library/LaunchAgents/$PLIST_NAME"
    echo "  Start service: launchctl load ~/Library/LaunchAgents/$PLIST_NAME"
}

echo "Installing LiteLLM..."
find_litellm_binary
generate_plist
ensure_launch_agents_dir
unload_existing_service
symlink_plist
load_service
print_success_message
