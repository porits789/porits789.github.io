---
id: DOC-013
title: RELEASE_CHECKLIST
phase: P3
tags: [release, ops, security]
requires: [DOC-006]
used_by: []
updated_at: 2026-03-07
---

# RELEASE_CHECKLIST

배포(공개) 전 반드시 아래를 확인한다.

## 1) Security Gate (필수)
- GitHub Actions `security-gate` 워크플로가 **PASS**여야 한다.
- Evidence는 Actions artifact로 남긴다:
  - `security-gate-evidence-<run_id>`

## 2) 페이지 노출 점검(필수)
- robots.txt / sitemap.xml / canonical meta 확인

## 3) Front Design QA (프론트 작업 시 필수)
- [ ] 컬러 분포 70/20/10 준수(Accent 과다 사용 없음)
- [ ] 라이트/다크 비교 시 체감 차이 명확
- [ ] Hero/본문/CTA 섹션 강도 계층 유지
- [ ] 버튼/폼/FAQ 상태(hover/focus/open/disabled) 구분 가능

## 4) 승인
- SECURITY_GATE 문서의 PASS 조건을 충족했음을 확인 후 진행
