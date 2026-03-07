---
id: DOC-007
title: RELEASE_CHECKLIST
phase: P3
tags: [ops, security]
requires: [DOC-002, DOC-004, DOC-005, DOC-006]
used_by: []
read_when:
  - "배포 직전 최종 점검할 때"
priority: should
status: active
owner: runner
updated_at: 2026-03-07
---

# RELEASE_CHECKLIST

## 사전 조건
- [ ] ROADMAP 마일스톤 충족
- [ ] SECURITY_GATE PASS

## 기능 점검
- [ ] 블로그 자동기록 동작
- [ ] 주간요약 생성
- [ ] 랜딩 링크/콘텐츠 정상

## 보안 점검
- [ ] secrets 0건
- [ ] SAST High 0건 (Medium은 경고)
- [ ] 공개 메타/robots/sitemap 검토

## 운영 점검
- [ ] 장애 대응/롤백 경로 확인
- [ ] 관측 지표 수집 확인

## 배포 승인 (확정)
- [ ] 최종 승인자: pori + atlas
- [ ] 배포 가능 시간: 상시

## 롤백 기준 (확정)
- [ ] 배포 후 핵심 기능 1개라도 실패하면 즉시 롤백

## 배포 후 모니터링 (확정)
- [ ] 배포 후 30분 모니터링 수행
