#!/bin/sh
# state-add.sh: add a checkpoint to the top of state.md (newest first).
#
# Usage:
#   scripts/state-add.sh "Basket discount codes" "done: field added, tests pass" "next: server side"
#   printf '%s\n' "done: ..." "next: ..." | scripts/state-add.sh "Basket discount codes"
#
# The first argument is the title. Each further argument (or each line on stdin) becomes a bullet.
# Set STATE_FILE to use a different file. The time is your local time.
set -eu

STATE_FILE="${STATE_FILE:-$(dirname "$0")/../state.md}"
ANCHOR="<!-- New entries go directly below this line"

[ $# -ge 1 ] || { echo "usage: $0 \"title\" [\"done: ...\" \"next: ...\" ...]" >&2; exit 2; }
title="$1"; shift

entry="$(mktemp)"; out="$(mktemp)"
trap 'rm -f "$entry" "$out"' EXIT

{
  printf '## %s - %s\n' "$(date '+%Y-%m-%d %H:%M')" "$title"
  if [ $# -gt 0 ]; then
    for line in "$@"; do printf -- '- %s\n' "$line"; done
  elif [ ! -t 0 ]; then
    while IFS= read -r line; do [ -n "$line" ] && printf -- '- %s\n' "${line#- }"; done
  fi
  printf '\n'
} > "$entry"

if [ ! -f "$STATE_FILE" ]; then
  printf '%s, newest first. scripts/state-add.sh does this for you. -->\n\n' "$ANCHOR" > "$STATE_FILE"
fi

# Insert the entry after the anchor line (and the blank line under it), or at the top if there is none.
if grep -qF "$ANCHOR" "$STATE_FILE"; then
  awk -v f="$entry" -v a="$ANCHOR" '
    done_ == 0 && index($0, a) == 1 { print; getline nxt; if (nxt != "") { print ""; } else { print nxt }
      while ((getline l < f) > 0) print l; done_ = 1; if (nxt != "") print nxt; next }
    { print }' "$STATE_FILE" > "$out"
else
  cat "$entry" "$STATE_FILE" > "$out"
fi
cat "$out" > "$STATE_FILE"
echo "added: $(head -1 "$entry")"
