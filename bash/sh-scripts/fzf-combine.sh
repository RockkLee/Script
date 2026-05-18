#!/usr/bin/env bash
#
# fzf-combine.sh — fuzzy-select multiple files, wrap each, and merge into one
#
# Usage:
#   ./fzf-combine.sh [-o OUTPUT]
#
#   -o OUTPUT   Path to the combined output file (default: combined.md)

set -euo pipefail

# Default output file
OUTPUT="combined.md"

# Parse optional -o
while getopts ":o:" opt; do
  case $opt in
  o) OUTPUT="$OPTARG" ;;
  *)
    echo "Usage: $0 [-o OUTPUT]" >&2
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))

# Ask fzf for your selections (newline-separated)
selections=$(find . -type f |
  sed 's|^\./||' |
  fzf --multi --height=80% --border --prompt="Select files> ")

# If nothing chosen, exit
if [ -z "$selections" ]; then
  echo "❌ No files selected."
  exit 1
fi

# Create/truncate the output
: >"$OUTPUT"

# Loop over each selected path
count=0
while IFS= read -r file; do
  count=$((count + 1))
  {
    echo "- $file"
    echo '```'
    cat "$file"
    echo '```'
    echo
  } >>"$OUTPUT"
done <<<"$selections"

echo "✅ Merged $count files into $OUTPUT with <demo> wrappers."
