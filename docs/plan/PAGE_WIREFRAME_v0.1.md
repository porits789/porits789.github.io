---
id: DOC-009
title: PAGE_WIREFRAME_v0.1
phase: P2
tags: [landing, blog]
requires: [DOC-003, DOC-005, DOC-008]
used_by: [DOC-007]
read_when:
  - "랜딩/블로그 페이지 골격을 구현 전에 공유할 때"
priority: must
status: active
owner: dev
updated_at: 2026-03-07
---

# PAGE WIREFRAME v0.1

## Landing (실험 결과 공유 중심)
1. **Hero**
   - Title: "Vibe Coding Study"
   - Subtitle: "실험하고 기록하고 학습을 축적합니다"
   - CTA: "최신 실험 보기"

2. **Recent Experiments (3 cards)**
   - 카드 필드: 제목 / 날짜 / 핵심 결과 1줄 / Read

3. **Weekly Highlight (1 card, 강조형)**
   - 주간 배운 점 3개 요약

4. **How We Work (4-step)**
   - 가설 → 구현 → 검증 → 회고

5. **Next Experiments**
   - 다음 실험 2~3개 backlog

6. **Footer**
   - GitHub / RSS / Contact

## Blog List
- 상단: 검색/태그 필터
- 본문: 최신순 포스트 카드 리스트
- 사이드(모바일에서는 하단): 주간요약 바로가기

## Post Detail
- 메타: 제목, 날짜, 태그
- 본문 템플릿:
  1) 배경
  2) 시도
  3) 결과
  4) 배운 점
  5) 다음 액션

## 모바일 우선 규칙
- 1열 레이아웃 고정
- Hero + CTA first screen에 노출
- 카드 텍스트는 3줄 요약 제한
