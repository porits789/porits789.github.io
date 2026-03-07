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

## 3) 승인
- SECURITY_GATE 문서의 PASS 조건을 충족했음을 확인 후 진행
