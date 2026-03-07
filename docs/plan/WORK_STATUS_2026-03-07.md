---
id: DOC-011
title: WORK_STATUS_2026-03-07
phase: P3
tags: [status, ops]
requires: [DOC-010]
used_by: []
updated_at: 2026-03-07
---

# WORK_STATUS_2026-03-07

이 문서는 **Track A 연속 진행**의 작업 상태를 기록한다.

## 요약
- 목표: Track A (T1→T7) 순차 구현, 각 T 완료 시 push + 상태 문서 업데이트

## 진행 로그

### T1 — Jekyll 블로그 기본 골격 세팅 ✅
- 상태: done
- 핵심 산출:
  - Jekyll 기본 레이아웃/인덱스/샘플 포스트
  - Hero 문구 반영(Title/Subtitle)
- DoD: PASS

### T2 — 포스트 스키마/템플릿 고정 ✅
- 상태: done
- 완료 내용:
  - frontmatter 6개 템플릿 문서화(`docs/templates/POST_TEMPLATE.md`)
  - 샘플 포스트 2개(weekly 포함) 추가
  - 랜딩에서 weekly 분리 표시 확인(Recent Experiments에서 weekly 제외)
- DoD: PASS

### T3 — Push 이벤트 자동 포스트 생성기 ✅
- 상태: done
- 구현 내용:
  - GitHub Actions workflow: `.github/workflows/push-log.yml`
  - 생성 스크립트: `scripts/gen_push_post.sh`
  - push 시 포스트 생성 후 커밋/푸시(워크플로에서 untracked 변경까지 감지)
- DoD: PASS (워크플로 실행 성공 + 자동 생성 포스트 커밋 확인)
