#!/usr/bin/env bash
# Installs global Claude files to $HOME/.claude/
# Double-click to run in macOS Finder

cd "$(dirname "$0")"
SRC="$(pwd)/files"
DEST="$HOME/.claude"

mkdir -p "$DEST"

for file in "$SRC"/*; do
  name="$(basename "$file")"
  if [ -f "$DEST/$name" ]; then
    echo "  Skipping $name — already exists in $DEST"
  else
    cp "$file" "$DEST/$name"
    echo "  Copied $name -> $DEST/$name"
  fi
done

echo ""
echo "Done. Global Claude files installed to $DEST"
echo ""
read -r -p "Press Enter to close..."
