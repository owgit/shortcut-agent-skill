#!/bin/bash
# Sign an Apple Shortcut plist and open it in Shortcuts app.
#
# Usage:
#   bash scripts/sign_and_open.sh "shortcut_name"
#   bash scripts/sign_and_open.sh "shortcut_name" --no-open
#
# Expects: output/<name>.plist
# Produces: output/<name>.shortcut (signed)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="$PROJECT_DIR/output"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <shortcut_name> [--no-open]"
  echo "  Expects output/<shortcut_name>.plist to exist"
  exit 1
fi

NAME="$1"
# Convert to safe filename (lowercase, underscores)
SAFE_NAME=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]/_/g' | sed 's/__*/_/g')
NO_OPEN="${2:-}"

PLIST_INPUT="$OUTPUT_DIR/${SAFE_NAME}.plist"
UNSIGNED="$OUTPUT_DIR/${SAFE_NAME}_unsigned.shortcut"
SIGNED="$OUTPUT_DIR/${SAFE_NAME}.shortcut"

if [ ! -f "$PLIST_INPUT" ]; then
  echo "Error: $PLIST_INPUT not found"
  echo "Run generate_plist.py first."
  exit 1
fi

# Validate plist
if ! plutil -lint "$PLIST_INPUT" > /dev/null 2>&1; then
  echo "Error: Invalid plist format in $PLIST_INPUT"
  plutil -lint "$PLIST_INPUT"
  exit 1
fi

# shortcuts sign requires .shortcut extension on input
cp "$PLIST_INPUT" "$UNSIGNED"

echo "Signing: $PLIST_INPUT -> $SIGNED"
shortcuts sign --mode anyone --input "$UNSIGNED" --output "$SIGNED"

SIGN_EXIT=$?

# Clean up temporary unsigned file
rm -f "$UNSIGNED"

if [ $SIGN_EXIT -eq 0 ]; then
  echo "Signed successfully: $SIGNED"

  if [ "$NO_OPEN" != "--no-open" ]; then
    echo "Opening in Shortcuts app..."
    open "$SIGNED"
  fi
else
  echo "Error: Signing failed"
  exit 1
fi
