# SPEC_LITE v0.1 — landingpage-experiment

- **Goal:**
  - 실험 결과 공유를 1순위로 하는 랜딩페이지를 제작해 `vibe-coding-study`의 실험 기록 접근성과 전달력을 높인다.
- **Non-goals:**
  - 완전한 제품 사이트화(대시보드/회원/결제), 대규모 브랜드 리디자인.
- **Scope (In):**
  - 랜딩 핵심 섹션: 프로젝트 소개, 최근 실험 결과, 주간 하이라이트, 다음 실험 계획.
  - CTA: 실험 기록(블로그)로 이동하는 1차 행동 유도.
  - 공개 범위: Public(검색 허용).
  - 초기 실험 지표 정의: 방문→실험글 클릭률(CTR), 평균 체류시간.
- **Scope (Out):**
  - 로그인/계정 기능, 결제, 복잡한 개인화 추천.
- **Acceptance Criteria:**
  - AC1: 랜딩 단일 URL에서 핵심 실험 결과를 30초 내 파악 가능하다.
  - AC2: 최근 실험/주간 하이라이트가 블로그 소스와 연동 또는 수동 갱신 가능한 구조다.
  - AC3: 기본 웹 성능/접근성 체크를 통과한다(모바일 포함).
- **Open Questions (TBD):**
  - TBD: 디자인 톤(미니멀 vs 실험실 스타일)과 레퍼런스 2~3개.
  - TBD: 분석 도구 선택(가벼운 self-hosted vs 외부 analytics).
  - TBD: 업데이트 방식(완전 자동 동기화 vs 반자동 큐레이션).
- **Risks (Top 3):**
  1. 랜딩 메시지 과잉으로 핵심 가치(실험 결과 공유)가 흐려질 위험.
  2. 블로그 구조와 랜딩 카드 데이터 불일치.
  3. Public 인덱싱 시 미완성 페이지가 먼저 노출될 가능성.
- **Policy Flags:**
  - Secrets/Keys: no
  - Billing: no
  - Account/Auth: no
  - External Deployment/Public Exposure: yes
- **Handoff:**
  - Dev: 랜딩 IA/컴포넌트 구현, 실험 카드 데이터 소스 연결, 성능 최적화.
  - Runner: 반응형/브라우저 점검, 링크 무결성, 기본 지표 수집 확인.
  - Security: 공개 전 robots/sitemap/메타 설정 검토 및 민감정보 노출 점검.

- **Related Specs:**
  - 블로그 자동 기록 스펙: [`/docs/specs/blog-auto-record/SPEC_LITE.md`](/docs/specs/blog-auto-record/SPEC_LITE.md)