#!/usr/bin/env bash
set -euo pipefail

# Generates an INTERNAL push log (not a public blog post).
# Intended for GitHub Actions on `push` to `main`.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

DATE_YMD="$(date +%Y-%m-%d)"
TIME_KST="$(TZ=Asia/Seoul date +"%Y-%m-%d %H:%M:%S %z")"

# Idempotency key (spec): {date}-{commitHash|eventId}
# - Prefer commit hash for push events
# - Fall back to an event/run id when SHA is not available
SHA_FULL="${GITHUB_SHA:-$(git rev-parse HEAD 2>/dev/null || true)}"
SHA_SHORT="$(echo "${SHA_FULL}" | cut -c1-8)"
EVENT_ID="${GITHUB_RUN_ID:-${GITHUB_RUN_NUMBER:-local}}"

if [[ -n "${SHA_SHORT}" ]]; then
  IDEMPOTENCY_KEY="${DATE_YMD}-${SHA_SHORT}"
else
  IDEMPOTENCY_KEY="${DATE_YMD}-${EVENT_ID}"
fi

LOG_DIR="docs/ops/push-logs"
mkdir -p "$LOG_DIR"

FILENAME="$LOG_DIR/push-${IDEMPOTENCY_KEY}.md"
DUP_LOG="$LOG_DIR/duplicates.log"

if [[ -f "$FILENAME" ]]; then
  echo "Duplicate detected (idempotency_key=${IDEMPOTENCY_KEY}). Skipping: $FILENAME"
  echo "${TIME_KST}\tkey=${IDEMPOTENCY_KEY}\tsha=${SHA_FULL:-none}\tevent_id=${EVENT_ID}\tfile=${FILENAME}" >> "$DUP_LOG"
  exit 0
fi

COMMIT_SUBJECT="$(git log -1 --pretty=%s "$SHA_FULL" 2>/dev/null || echo "push-log")"
COMMIT_BODY="$(git log -1 --pretty=%b "$SHA_FULL" 2>/dev/null || true)"
CHANGED_FILES="$(git show --pretty="" --name-only "$SHA_FULL" 2>/dev/null | sed '/^$/d' || true)"

cat > "$FILENAME" <<EOF
# Push Log — ${IDEMPOTENCY_KEY}

- time_kst: ${TIME_KST}
- idempotency_key: ${IDEMPOTENCY_KEY}
- sha: ${SHA_FULL:-}
- event_id: ${EVENT_ID}
- subject: ${COMMIT_SUBJECT}

## Details

${COMMIT_BODY}

## Changed files

$(if [[ -n "$CHANGED_FILES" ]]; then echo "$CHANGED_FILES" | sed 's/^/- /'; else echo "- (none)"; fi)
EOF

echo "Generated internal log: $FILENAME"
