#!/usr/bin/env bash
# filter_intra_mappings.sh
#
# Usage:
#   ./filter_intra_mappings.sh report.txt > filtered.txt
#   cat report.txt | ./filter_intra_mappings.sh > filtered.txt

set -euo pipefail

input="${1:-/dev/stdin}"

awk '
function flush_block() {
  if (in_block) {
    if (has_intra) {
      for (i = 1; i <= blk_n; i++) print blk[i]
    }
    # else: discard the block
  }
  in_block = 0
  has_intra = 0
  blk_n = 0
}

# Controller/file header starts a new section; close any open mapping block.
$0 ~ /^==== / {
  flush_block()
  print
  next
}

# Start of a mapping block
$0 ~ /^>> mapping root:/ {
  flush_block()
  in_block = 1
  blk_n = 1
  blk[blk_n] = $0
  if ($0 ~ /Intra/) has_intra = 1
  next
}

# Lines inside a mapping block
in_block {
  blk[++blk_n] = $0
  if ($0 ~ /Intra/) has_intra = 1
  next
}

# Lines outside any mapping block
{
  print
}

END {
  flush_block()
}
' "$input"
