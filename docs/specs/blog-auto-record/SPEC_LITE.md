# SPEC_LITE v0.1 — blog-auto-record

- **Goal:**
  - `vibe-coding-study` 프로젝트 변경 이력을 자동으로 학습 자산(MDX)으로 축적하고, 주간 회고 1개를 자동 생성한다.
- **Non-goals:**
  - 고급 SEO 최적화, 광고/수익화, 다국어 번역, 복잡한 CMS 구축.
- **Scope (In):**
  - 트리거 1: `push to main` 이벤트 시 포스트 초안/업데이트 생성.
  - 트리거 2: 매일 23:00(KST) 배치 실행(누락 보정 + 일일 로그 집계).
  - 산출물 1: MDX 포스트(실험 배경/변경점/결과/다음 실험).
  - 산출물 2: 주간 요약 포스트 1개(핵심 학습/실패/다음 주 액션).
  - 공개 범위: Public(검색 허용).
- **Scope (Out):**
  - 자동 배포 파이프라인 최적화 전부, 외부 SNS 자동 발행, 유료 구독 시스템.
- **Acceptance Criteria:**
  - AC1: `main` push 후 정의된 시간 내 MDX 로그가 생성/갱신된다.
  - AC2: 매일 23:00 실행으로 누락 기록이 보정되고, 로그 중복 규칙이 동작한다.
  - AC3: 주 1회 주간 요약 포스트가 생성되며, 최소 3개 섹션(배운 점/문제/다음 액션)을 포함한다.
- **Open Questions (TBD):**
  - TBD: MDX 저장소 구조(`content/posts` vs `blog/`) 최종 경로.
  - TBD: push 이벤트당 1포스트 vs 일자 단위 합산 정책.
  - TBD: 주간 요약 생성 기준 시점(일요일 23:00 등).
- **Risks (Top 3):**
  1. 자동 생성 품질 저하(중복/빈약한 요약)로 신뢰 하락.
  2. 스케줄/이벤트 중복 실행으로 글 중복 발행.
  3. Public 노출 시 실수로 민감정보 포함 가능성.
- **Policy Flags:**
  - Secrets/Keys: no
  - Billing: no
  - Account/Auth: no
  - External Deployment/Public Exposure: yes
- **Handoff:**
  - Dev: 이벤트/스케줄 기반 생성기 구현, 중복 방지 키 설계, MDX 템플릿 적용.
  - Runner: 트리거/크론 실행 검증, 누락/중복 회귀 테스트, 주간 요약 생성 확인.
  - Security: 공개 전 민감정보 필터(토큰/키/개인정보 패턴) 점검 규칙 추가.

- **Related Specs:**
  - 랜딩/노출 실험 스펙: [`/docs/specs/landingpage-experiment/SPEC_LITE.md`](/docs/specs/landingpage-experiment/SPEC_LITE.md)