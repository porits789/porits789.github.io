# Post template (vibe-coding-study)

아래 frontmatter 6개는 **필수**입니다.

- `title`
- `date`
- `tags`
- `source`
- `summary`
- `status` (`draft|published`)

## 일반 포스트

```yaml
---
layout: post
title: "<TITLE>"
date: 2026-03-07 17:30:00 +0900
tags: [tag1, tag2]
source: manual
summary: "<ONE-LINE SUMMARY>"
status: published
---
```

## 주간 요약(weekly)

주간 요약은 `categories: [weekly]`로 구분합니다.

```yaml
---
layout: post
title: "Weekly Highlights — 2026-W10"
date: 2026-03-09 23:00:00 +0900
tags: [weekly]
categories: [weekly]
source: schedule
summary: "이번 주의 핵심 실험/배움 요약"
status: published
---
```
