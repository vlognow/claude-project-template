#!/usr/bin/env bash
# Installs global Claude files to $HOME/.claude/
# Double-click to run in macOS Finder

cd "$(dirname "$0")"
SRC="$(pwd)/files"
DEST="$HOME/.claude"

mkdir -p "$DEST"

for file in "$SRC"/*; do
  name="$(basename "$file")"
  if [ -f "$file" ]; then
    if [ -f "$DEST/$name" ]; then
      echo "  Skipping $name — already exists in $DEST"
    else
      cp "$file" "$DEST/$name"
      echo "  Copied $name -> $DEST/$name"
    fi
  elif [ -d "$file" ]; then
    mkdir -p "$DEST/$name"
    for subfile in "$file"/*; do
      subname="$(basename "$subfile")"
      if [ -f "$DEST/$name/$subname" ]; then
        echo "  Skipping $name/$subname — already exists in $DEST"
      else
        cp "$subfile" "$DEST/$name/$subname"
        echo "  Copied $name/$subname -> $DEST/$name/$subname"
      fi
    done
  fi
done

echo ""
echo "Done. Global Claude files installed to $DEST"
echo ""
read -r -p "Press Enter to close..."
