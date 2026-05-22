#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Converting VIA layout to ZMK keymap..."
python3 "$SCRIPT_DIR/convert.py"

echo ""
echo "Done! To build firmware:"
echo "  ./build.sh"
