#!/usr/bin/env bash
set -euo pipefail

# Checks public exposure basics in the built site output.
# Requirements (SECURITY_GATE): robots/sitemap/meta/canonical check.

SITE_DIR="${1:-_site}"

fail() { echo "FAIL: $*"; exit 1; }
warn() { echo "WARN: $*"; }
pass() { echo "PASS: $*"; }

[[ -d "$SITE_DIR" ]] || fail "site dir not found: $SITE_DIR"

# 1) robots.txt (source + output)
if [[ -f "robots.txt" ]]; then
  pass "robots.txt exists in repo root"
else
  fail "robots.txt missing in repo root"
fi

if [[ -f "$SITE_DIR/robots.txt" ]]; then
  pass "robots.txt rendered to $SITE_DIR/robots.txt"
else
  fail "robots.txt not found in built site"
fi

# 2) sitemap.xml
if [[ -f "$SITE_DIR/sitemap.xml" ]]; then
  pass "sitemap.xml exists"
else
  fail "sitemap.xml missing (consider jekyll-sitemap plugin)"
fi

# 3) meta/canonical (check home page)
INDEX_HTML="$SITE_DIR/index.html"
[[ -f "$INDEX_HTML" ]] || fail "index.html missing in built site"

if grep -q "rel=\"canonical\"" "$INDEX_HTML"; then
  pass "canonical link tag present on index"
else
  fail "canonical link tag missing on index"
fi

# 4) meta description
if grep -qi "name=\"description\"" "$INDEX_HTML"; then
  pass "meta description present on index"
else
  warn "meta description not found on index (seo-tag might still output og:description)"
fi
