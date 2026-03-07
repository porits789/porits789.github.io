---
id: DOC-010
title: TRACK_A_TICKETS_v0.1
phase: P3
tags: [blog, ops]
requires: [DOC-003, DOC-004, DOC-006, DOC-007]
used_by: []
read_when:
  - "Track A 구현 전 작업을 실행 단위로 분해할 때"
priority: must
status: active
owner: dev
updated_at: 2026-03-07
---

# TRACK A 티켓 분해 (v0.1)

목표: push 기반 자동 기록 + daily 보정 + weekly 요약까지 운영 가능한 최소 기능 완성.

## T1. Jekyll 블로그 기본 골격 세팅
- 작업:
  - Jekyll 사이트 초기 구조 구성 (`_posts`, 기본 레이아웃, 인덱스)
  - Hero/리스트 중심 블로그형 랜딩 반영(버튼 CTA 없음)
- DoD:
  - 로컬에서 글 목록/상세 렌더 확인
  - `Vibe Coding Study` Hero 문구 반영 확인

## T2. 포스트 스키마/템플릿 고정
- 작업:
  - Front matter 6개(`title,date,tags,source,summary,status`) 템플릿 생성
  - push-log / weekly-summary 카테고리 규칙 반영
- DoD:
  - 샘플 포스트 2개 생성 시 규칙 위반 없이 렌더
  - weekly는 `category: weekly`로 분리 표시

## T3. Push 이벤트 자동 포스트 생성기
- 작업:
  - `push to main` 트리거 시 포스트 1개 자동 생성
  - 생성 기본값: `status: published`
- DoD:
  - 테스트 push 1회당 포스트 1개 생성
  - 본문에 변경 요약/커밋 참조(source) 포함

## T4. 중복 방지 및 idempotency
- 작업:
  - 중복 키 `{date}-{commitHash|eventId}` 적용
  - 같은 이벤트 재실행 시 포스트 중복 생성 방지
- DoD:
  - 동일 이벤트 2회 입력 시 결과 포스트 1개 유지
  - 중복 감지 로그 남김

## T5. 실패 복구 플로우
- 작업:
  - 실패 시 즉시 1회 재시도
  - 재시도 실패 건을 daily 23:00 보정 큐로 이관
- DoD:
  - 실패 시나리오에서 보정 큐 이관 확인
  - daily 보정 후 누락 포스트 복구 확인

## T6. 주간 요약 생성기
- 작업:
  - 일요일 23:00(KST) 주간 요약 자동 생성
  - 섹션 고정: 배운 점 / 문제 / 다음 액션
- DoD:
  - 주간 요약 포스트 자동 생성 성공
  - 3개 섹션 포함 여부 검증 통과

## T7. 보안/릴리즈 게이트 연결
- 작업:
  - Secrets 0건, SAST High 0건, 노출점검(robots/meta/sitemap) 체크 실행
  - 실패 시 배포 중단 + evidence 저장
- DoD:
  - 보안 점검 결과 파일 링크 확보
  - FAIL/ESCALATE 조건 문서와 동작 일치

## 실행 순서
1) T1 → T2 → T3 → T4
2) T5 → T6
3) T7 (배포 직전 게이트)

## 메모
- 승인자: pori + atlas
- 배포 후 30분 모니터링 필수
- 핵심 기능 1개라도 실패 시 즉시 롤백
