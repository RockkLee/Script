#!/bin/bash
# wrap_md_merge.sh                             # Script name – for reference only

set -eu                                                  # -e: abort on error, -u: abort on unset vars
(set -o pipefail) 2>/dev/null && set -o pipefail || true # Enable pipefail if supported

# ----- argument check -------------------------------------------------------
if [ "$#" -eq 0 ]; then                  # No input files?
  echo "Usage: $0 <file1> [file2 …]" >&2 # Tell the user what to do
  exit 1                                 # Terminate with error
fi                                       # End argument check

output_file="$(pwd)/wrapped_sources.md" # Destination Markdown file (save in the CWD)
: >"$output_file"                       # Truncate or create the file

# ----- main loop -------------------------------------------------------------
for input_file in "$@"; do        # Process each argument
  if [ ! -f "$input_file" ]; then # Skip non‑regular files
    echo "Warning: '$input_file' is not a regular file – skipping." >&2
    continue # Move on to the next argument
  fi

  {                                  # Start block whose output is appended
    printf -- '- %s\n' "$input_file" # File path on its own line
    printf '```\n'                   # Opening Markdown fence
    cat "$input_file"                # Emit the file’s content
    printf '\n```\n\n'               # Closing fence + blank line
  } >>"$output_file"                 # Append block to the Markdown file
done                                 # Loop finished

echo "✅ All wrapped files saved to: $output_file" # Tell the user we’re done
