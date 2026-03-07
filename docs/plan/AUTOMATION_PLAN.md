---
id: DOC-004
title: AUTOMATION_PLAN
phase: P2
tags: [blog, ops]
requires: [DOC-002, DOC-003]
used_by: [DOC-007]
read_when:
  - "자동기록 트리거/스케줄/중복방지 로직을 설계할 때"
priority: must
status: active
owner: dev
updated_at: 2026-03-07
---

# AUTOMATION_PLAN

## 목적
- push + schedule 기반 자동 기록을 정의한다.

## 트리거 (확정)
- Event: push to main
- Schedule: daily 23:00 (KST)
- Weekly: 일요일 23:00 (KST)

## 처리 플로우(확정)
1. push(main) 이벤트 수신
2. 포스트 자동 생성 (`status: published`)
3. 중복 검사(중복 키 기준)
4. 저장/업데이트
5. 실패 시 즉시 1회 재시도
6. 재시도 실패 건은 daily 23:00 보정 큐로 이관

## 중복 방지 키(초안)
- {date}-{commitHash|eventId}

## 장애/복구 (확정)
- 실패 로그 저장
- 즉시 1회 재시도
- 재시도 실패 시 daily 23:00 보정으로 누락 복구

## 검증 기준
- 이벤트 누락 없음
- 중복 생성 없음
- 주간 요약 생성 성공

## 미결사항(TBD)
- (해결) 워크플로 실행 위치: GitHub Actions(CI)에서 실행 (push to main)
- 보정 큐의 최대 지연 허용 시간(SLA)
