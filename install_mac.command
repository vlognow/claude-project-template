#!/usr/bin/env bash
# Installs global Claude files to $HOME/.claude/
# Double-click to run in macOS Finder

cd "$(dirname "$0")"
SRC="$(pwd)/files"
DEST="$HOME/.claude"

mkdir -p "$DEST"

for file in "$SRC"/*; do
  name="$(basename "$file")"
  if [ -f "$file" ] && [[ "$name" != *.ps1 ]]; then
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
      if [ -f "$subfile" ]; then
        if [ -f "$DEST/$name/$subname" ]; then
          echo "  Skipping $name/$subname — already exists in $DEST"
        else
          cp "$subfile" "$DEST/$name/$subname"
          echo "  Copied $name/$subname -> $DEST/$name/$subname"
        fi
      elif [ -d "$subfile" ]; then
        mkdir -p "$DEST/$name/$subname"
        for subsubfile in "$subfile"/*; do
          subsubname="$(basename "$subsubfile")"
          if [ -f "$DEST/$name/$subname/$subsubname" ]; then
            echo "  Skipping $name/$subname/$subsubname — already exists in $DEST"
          else
            cp "$subsubfile" "$DEST/$name/$subname/$subsubname"
            echo "  Copied $name/$subname/$subsubname -> $DEST/$name/$subname/$subsubname"
          fi
        done
      fi
    done
  fi
done

echo ""
echo "Done. Global Claude files installed to $DEST"
echo ""
sleep 1
read -r -p "Press Enter to close..."
