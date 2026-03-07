---
id: DOC-008
title: DESIGN_DECISION_v0.1
phase: P2
tags: [landing, plan]
requires: [DOC-005]
used_by: [DOC-007]
read_when:
  - "디자인 방향/컴포넌트/스타일을 확정할 때"
priority: must
status: active
owner: pm
updated_at: 2026-03-07
---

# DESIGN DECISION v0.1 (Confirmed)

## 기준
- 빠른 구현 + 높은 가독성 + 학습기록 전달력

## 최종 선택
1. **블로그 본체 스타일**: Beautiful Jekyll 기반 (심플/텍스트 중심)
2. **랜딩 구조 패턴**: Landingfolio의 SaaS 섹션 패턴 차용
3. **비주얼 디테일**: Lapa 스타일(여백/타이포/카드 밀도) 참고

## 스타일 토큰 (v0.1)
- Tone: Light, clean, technical
- Primary color: `#2563EB` (blue)
- Accent color: `#10B981` (green)
- Text color: `#0F172A`
- Background: `#F8FAFC`
- Border: `#E2E8F0`

## 타이포
- Headings: Inter / Pretendard 700
- Body: Inter / Pretendard 400-500
- Code: JetBrains Mono

## 컴포넌트 규칙
- Card radius: 12px
- Section spacing: 64px (desktop), 40px (mobile)
- Max content width: 960px
- CTA 버튼: Primary 1개만 강조, secondary는 텍스트 링크

## 콘텐츠 원칙
- Hero는 1문장 가치제안 + 1개 CTA
- 실험 카드에는 `가설-시도-결과-배운점` 4필드 유지
- 한 화면에서 최신 실험 3개와 주간요약 1개를 확인 가능하게 구성

## 비기능 기준
- Mobile-first
- Core Web Vitals 기본 충족 지향
- 접근성(명도 대비, 링크 포커스 표시) 기본 준수
