#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

litellm --config "$SCRIPT_DIR/config.yaml"
