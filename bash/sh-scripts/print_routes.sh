#!/usr/bin/env bash
set -euo pipefail

JAVA_DIR="${1:-./src/main/java/com/eyesmedia/cusmgconsl/controller}"
IAC_DIR="${2:-../eyesmedia-iac}"

# Produce: file<TAB>root<TAB>nextline
pairs=$(
  rg -n -I '^\s*@\w+Mapping\("' -g '*.java' "$JAVA_DIR" --with-filename |
    awk -F: '
      {
        file=$1
        ln=$2
        line=$3

        # get next line from same file
        cmd = "sed -n \"" (ln+1) "p\" \"" file "\""
        cmd | getline nextline
        close(cmd)

        # extract url inside Mapping("...")
        url=line
        sub(/^.*Mapping\("/, "", url)
        sub(/".*$/, "", url)

        sub(/^\/+/, "", url)     # strip leading /
        root=url
        sub(/\/.*/, "", root)   # first segment only
        sub(/\{.*/, "", root)   # drop {param} if first

        # avoid tabs breaking fields
        gsub(/\t/, " ", nextline)

        if (root != "") print file "\t" root "\t" nextline
      }
    ' |
    sort -u
)

prev_file=""
while IFS=$'\t' read -r file root nextline; do
  if [[ "$file" != "$prev_file" ]]; then
    echo "==== $file ===="
    prev_file="$file"
  fi

  echo ">> mapping root: $root"
  echo "   next line: $nextline"

  rg ".*/justka/custmgconsl/.*/$root" -g '*.json' "$IAC_DIR" | rg 'PROD' || true
  echo
done <<<"$pairs"

