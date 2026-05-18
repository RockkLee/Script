#!/bin/bash
# Usage: ./git-changes.sh <author> <pattern>
# Example: ./git-changes.sh sam.lee Controller

AUTHOR=$1
PATTERN=$2

# awk -v
#   -v: variables
#     This can let you define input variables
git log --author="$AUTHOR" --pretty=format:"%H %ad" --date=short --name-only |
  awk -v pattern="$PATTERN" '
  # Define variables (You can only define variables here in AWK)
  BEGIN {
    last = ""   # initialize variable before reading any input
  }

  # If line starts with 40-hex hash + space (commit hash + date)
  /^[0-9a-f]{40} / {
    hash=$1   # store full commit hash
    date=$2   # store commit date
    next      # skip remaining rules for this line
  }

  # If line contains the given pattern, print under current commit
  # $x:
  #   7b4c1d8e0f39b45a7c7a2f8f9a8a9b2f9e72e3d4 2025-09-10
  #     $0 = the whole line (7b4c1d8e0f39b45a7c7a2f8f9a8a9b2f9e72e3d4 2025-09-10)
  #     $1 = 7b4c1d8e0f39b45a7c7a2f8f9a8a9b2f9e72e3d4 (the commit hash) (the first text separated by blank)
  #     $2 = 2025-09-10 (the commit date) (the second text separated by blank)
  # ~:
  #   AWK’s regex match operator
  #     which means the regex defined at the begining: `/^[0-9a-f]{40} /`
  # pattern:
  #   This is a variable passed in from the shell with `-v pattern="$PATTERN"`.
  # 
  $0 ~ pattern {
    if (hash != last) {
      # if (last != "") print ""   # blank line between commits
      print hash, date           # print commit hash + date
      last = hash
    }
    print "  " $0                # print matching filename
  }
'
