#!/usr/bin/env bash
# Installs global Claude files to $HOME/.claude/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/files"
DEST="$HOME/.claude"

mkdir -p "$DEST"

for file in "$SRC"/*; do
  name="$(basename "$file")"
  if [ -f "$DEST/$name" ]; then
    read -r -p "  '$name' already exists in $DEST. Overwrite? [y/N] " answer
    case "$answer" in
      [yY]*) ;;
      *) echo "  Skipping $name."; continue ;;
    esac
  fi
  cp "$file" "$DEST/$name"
  echo "  Copied $name -> $DEST/$name"
done

echo ""
echo "Done. Global Claude files installed to $DEST"
