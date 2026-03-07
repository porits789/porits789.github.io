#!/usr/bin/env bash
set -euo pipefail

# Generates an INTERNAL push log (not a public blog post).
# Intended for GitHub Actions on `push` to `main`.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

SHA_FULL="${GITHUB_SHA:-$(git rev-parse HEAD)}"
SHA_SHORT="$(echo "$SHA_FULL" | cut -c1-8)"
DATE_YMD="$(date +%Y-%m-%d)"
TIME_KST="$(TZ=Asia/Seoul date +"%Y-%m-%d %H:%M:%S %z")"

LOG_DIR="docs/ops/push-logs"
mkdir -p "$LOG_DIR"

FILENAME="$LOG_DIR/${DATE_YMD}-push-${SHA_SHORT}.md"

if [[ -f "$FILENAME" ]]; then
  echo "Log already exists: $FILENAME"
  exit 0
fi

COMMIT_SUBJECT="$(git log -1 --pretty=%s "$SHA_FULL" 2>/dev/null || echo "push-log")"
COMMIT_BODY="$(git log -1 --pretty=%b "$SHA_FULL" 2>/dev/null || true)"
CHANGED_FILES="$(git show --pretty="" --name-only "$SHA_FULL" 2>/dev/null | sed '/^$/d' || true)"

cat > "$FILENAME" <<EOF
# Push Log — ${SHA_SHORT}

- time_kst: ${TIME_KST}
- sha: ${SHA_FULL}
- subject: ${COMMIT_SUBJECT}

## Details

${COMMIT_BODY}

## Changed files

$(if [[ -n "$CHANGED_FILES" ]]; then echo "$CHANGED_FILES" | sed 's/^/- /'; else echo "- (none)"; fi)
EOF

echo "Generated internal log: $FILENAME"
