#!/bin/bash
# LiteLLM LaunchAgent Uninstaller
# Website: https://www.litellm.ai/

set -e

PLIST_NAME="com.litellm.proxy.plist"
PLIST_TARGET="$HOME/Library/LaunchAgents/$PLIST_NAME"

echo "Uninstalling LiteLLM LaunchAgent..."

# Unload service if loaded
if launchctl list | grep -q "com.litellm.proxy"; then
    echo "Stopping LiteLLM service..."
    launchctl unload "$PLIST_TARGET" 2>/dev/null || true
fi

# Remove symlink/file
if [ -e "$PLIST_TARGET" ] || [ -L "$PLIST_TARGET" ]; then
    echo "Removing plist: $PLIST_TARGET"
    rm "$PLIST_TARGET"
fi

echo ""
echo "LiteLLM LaunchAgent uninstalled successfully!"
echo ""
echo "Note: Log files remain at /tmp/litellm.log and /tmp/litellm.error.log"
