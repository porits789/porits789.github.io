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

> 운영 규칙: push 로그는 **블로그(_posts) 금지**. 내부 문서 `docs/ops/push-logs/`로만 유지.

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

### T3 — Push 이벤트 자동 포스트 생성기 ✅ (정책 변경 반영)
- 상태: done
- 구현 내용:
  - GitHub Actions workflow: `.github/workflows/push-log.yml`
  - 생성 스크립트: `scripts/gen_push_post.sh`
  - 변경 정책: push 로그를 **블로그 포스트(_posts)** 로 만들지 않고, **내부 운영 로그(`docs/ops/push-logs`)** 로 저장
- DoD: PASS (워크플로 실행 성공 + 내부 로그 커밋 확인)

### T4 — 중복 방지 및 idempotency ✅
- 상태: done
- 완료 내용:
  - 중복 키 `{date}-{commitHash|eventId}`를 내부 push-log에 적용
  - 동일 키가 이미 존재하면 생성 스킵(idempotent)
  - 중복 감지 시 `docs/ops/push-logs/duplicates.log`에 기록
- DoD: PASS (동일 실행 2회 테스트로 중복 스킵 + duplicates.log 기록 확인)

### T6 — 주간 요약 자동 생성 ✅
- 상태: done
- 완료 내용:
  - GitHub Actions 스케줄(일 23:00 KST)로 주간 요약 자동 생성
  - 파일 규칙 확정: `_posts/{YYYY-MM-DD}-weekly-highlights-{YYYY}-w{WW}.md`
  - 섹션 고정: 배운 점 / 문제 / 다음 액션
- DoD: PASS (로컬 샘플 실행으로 생성/렌더 확인)

## 운영 룰 참조
- 프로젝트 운영/보고 규칙은 `docs/plan/PROJECT_RULES.md`를 기준으로 한다.
- 특히, 사용자 트리거 없이도 각 T 완료 시 즉시 사용자 안내를 수행한다.
