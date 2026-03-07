---
id: DOC-003
title: CONTENT_ARCHITECTURE
phase: P2
tags: [blog]
requires: [DOC-001]
used_by: [DOC-004, DOC-005]
read_when:
  - "Jekyll 콘텐츠 구조/메타데이터/저장 경로를 정할 때"
priority: must
status: active
owner: dev
updated_at: 2026-03-07
---

# CONTENT_ARCHITECTURE

## 목적
- 블로그 콘텐츠 구조를 일관되게 설계한다.

## 디렉토리 구조(확정)
- `_posts/` 단일 경로 사용
- 주간 요약은 `categories: [weekly]`로 구분

## 포스트 유형
- weekly-summary (자동, categories: [weekly])
- manual-note (수동)

> push-log는 블로그 포스트가 아니라 내부 운영 로그(`docs/ops/push-logs/`)로 유지한다.

## Frontmatter 규칙(확정)
- title:
- date:
- tags:
- source:
- summary:
- status: draft|published

## URL/slug 규칙
- /blog/{yyyy}/{mm}/{slug}

## 품질 기준
- 최소 섹션 수
- 링크 유효성
- 중복 방지

## 미결사항(TBD)
- 주간 요약 발행 시점(요일/시간) 최종 확정
- `source` 값의 표준 포맷(`git:<commit>`, `manual`, `schedule`) 확정
