#!/usr/bin/env bash
set -euo pipefail

# Generates a weekly summary post.
# - Schedule: Sunday 23:00 (KST)
# - Sections fixed: 배운 점 / 문제 / 다음 액션
# - Idempotent per ISO week (year-week)

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

NOW_KST="$(TZ=Asia/Seoul date +"%Y-%m-%d %H:%M:%S %z")"
DATE_YMD="$(TZ=Asia/Seoul date +%Y-%m-%d)"
ISO_YEAR_DEFAULT="$(TZ=Asia/Seoul date +%G)"
ISO_WEEK_DEFAULT="$(TZ=Asia/Seoul date +%V)"

# Overrides for testing (e.g., ISO_YEAR=2026 ISO_WEEK=11)
ISO_YEAR="${ISO_YEAR:-$ISO_YEAR_DEFAULT}"
ISO_WEEK="${ISO_WEEK:-$ISO_WEEK_DEFAULT}"

WEEK_KEY="${ISO_YEAR}-W${ISO_WEEK}"
# File naming rule (confirmed): YYYY-wNN (lowercase w)
WEEK_FILE_KEY="${ISO_YEAR}-w${ISO_WEEK}"

POST_DIR="_posts"
mkdir -p "$POST_DIR"

FILENAME="$POST_DIR/${DATE_YMD}-weekly-highlights-${WEEK_FILE_KEY}.md"

# Idempotency: if any weekly-highlights for this week exists (regardless of date), skip.
if ls "$POST_DIR"/*-weekly-highlights-${WEEK_FILE_KEY}.md >/dev/null 2>&1; then
  echo "Weekly summary already exists for ${WEEK_KEY}. Skipping."
  exit 0
fi

cat > "$FILENAME" <<EOF
---
layout: post
title: "Weekly Highlights — ${WEEK_KEY}"
date: ${NOW_KST}
tags: [weekly]
categories: [weekly]
source: schedule
summary: "이번 주의 핵심 실험/배움 요약"
status: published
---

## 배운 점

- (작성)

## 문제

- (작성)

## 다음 액션

- (작성)
EOF

echo "Generated weekly summary: $FILENAME"
