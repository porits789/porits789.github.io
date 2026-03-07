---
id: DOC-006
title: SECURITY_GATE
phase: P3
tags: [security, ops]
requires: [DOC-003, DOC-004, DOC-005]
used_by: [DOC-007]
read_when:
  - "퍼블릭 배포 전 보안 검토를 할 때"
priority: must
status: active
owner: security
updated_at: 2026-03-07
---

# SECURITY_GATE

## 목적
- Public 공개 전 최소 보안 기준(PASS/FAIL)을 고정한다.

## PASS 조건 (모두 충족)
1. Secrets scan 0건 (gitleaks)
2. SAST High 0건 (semgrep, Medium은 경고)
3. 의존성 취약점 확인 완료 (osv/audit)
4. 민감정보/개인정보 노출 없음
5. robots/sitemap/meta/canonical 점검 완료

## FAIL/ESCALATE 조건 (확정)
- Secrets 발견: 1건이라도 즉시 FAIL + 회전/폐기 계획
- SAST: High 1건 이상이면 FAIL (Medium은 경고)
- auth/billing/public exposure 관련 이슈: 무조건 ESCALATE

## 배포 전 체크 순서 (확정)
1. Secrets scan
2. SAST scan
3. 노출 점검(robots/meta/sitemap/canonical)
4. 승인

## 증거(Evidence) 저장
- /tmp/security-scan-*/ 결과 파일 링크
- 파일:라인, rule id, 도구 출력 첨부

## 롤백 원칙
- 공개 후 이슈 발견 시 즉시 비노출/롤백

## 미결사항(TBD)
- 정식 CI 보안게이트 파이프라인 위치
