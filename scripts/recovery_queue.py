#!/usr/bin/env python3
"""File-based recovery queue MVP.

Queue file: docs/ops/recovery-queue.jsonl
Deadletter: docs/ops/recovery-deadletter.jsonl

Record schema (spec):
- idempotency_key (string)
- job_type (string)
- payload (object)
- failed_at (string)
- error (string)
- retry_count (int)
- status (pending|done|dead)

This script supports:
- enqueue: add/append a pending record
- run-pending: iterate pending records and retry supported job types

Supported job_type:
- push-log: runs scripts/gen_push_post.sh with env overrides from payload
- weekly-summary: runs scripts/gen_weekly_summary.sh with env overrides from payload

Notes:
- Idempotency is enforced primarily by the downstream generator scripts.
- Queue is rewritten atomically on each run.
"""

from __future__ import annotations

import argparse
import datetime as dt
import json
import os
import subprocess
import sys
import tempfile
from typing import Any, Dict, List

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
QUEUE_PATH = os.path.join(ROOT, "docs", "ops", "recovery-queue.jsonl")
DEADLETTER_PATH = os.path.join(ROOT, "docs", "ops", "recovery-deadletter.jsonl")


def now_kst_iso() -> str:
    # Avoid pytz; manual offset is fine for logging.
    # KST is always +09:00.
    return dt.datetime.now(dt.timezone.utc).astimezone(dt.timezone(dt.timedelta(hours=9))).isoformat(timespec="seconds")


def read_jsonl(path: str) -> List[Dict[str, Any]]:
    if not os.path.exists(path):
        return []
    items: List[Dict[str, Any]] = []
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            items.append(json.loads(line))
    return items


def write_jsonl_atomic(path: str, items: List[Dict[str, Any]]) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    fd, tmp = tempfile.mkstemp(prefix=os.path.basename(path) + ".", dir=os.path.dirname(path))
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as f:
            for it in items:
                f.write(json.dumps(it, ensure_ascii=False) + "\n")
        os.replace(tmp, path)
    finally:
        try:
            if os.path.exists(tmp):
                os.unlink(tmp)
        except Exception:
            pass


def append_jsonl(path: str, item: Dict[str, Any]) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "a", encoding="utf-8") as f:
        f.write(json.dumps(item, ensure_ascii=False) + "\n")


def run_job(job_type: str, payload: Dict[str, Any]) -> None:
    env = os.environ.copy()
    # Allow passing env overrides as payload.env
    payload_env = payload.get("env") or {}
    if not isinstance(payload_env, dict):
        raise ValueError("payload.env must be an object")
    for k, v in payload_env.items():
        env[str(k)] = str(v)

    if job_type == "push-log":
        cmd = ["bash", "scripts/gen_push_post.sh"]
    elif job_type == "weekly-summary":
        cmd = ["bash", "scripts/gen_weekly_summary.sh"]
    else:
        raise ValueError(f"unsupported job_type: {job_type}")

    subprocess.run(cmd, cwd=ROOT, env=env, check=True)


def cmd_enqueue(args: argparse.Namespace) -> int:
    payload: Dict[str, Any] = {}
    if args.payload_json:
        payload = json.loads(args.payload_json)
        if not isinstance(payload, dict):
            raise SystemExit("payload_json must be a JSON object")

    record = {
        "idempotency_key": args.idempotency_key,
        "job_type": args.job_type,
        "payload": payload,
        "failed_at": args.failed_at or now_kst_iso(),
        "error": args.error or "",
        "retry_count": int(args.retry_count or 0),
        "status": args.status or "pending",
    }

    append_jsonl(QUEUE_PATH, record)
    print(f"ENQUEUED: {QUEUE_PATH}")
    return 0


def cmd_run_pending(args: argparse.Namespace) -> int:
    max_retries = int(args.max_retries)
    queue = read_jsonl(QUEUE_PATH)

    new_queue: List[Dict[str, Any]] = []

    for rec in queue:
        status = rec.get("status")
        if status != "pending":
            new_queue.append(rec)
            continue

        retry_count = int(rec.get("retry_count") or 0)
        job_type = str(rec.get("job_type"))
        payload = rec.get("payload") or {}
        if not isinstance(payload, dict):
            payload = {}

        try:
            run_job(job_type, payload)
            rec["status"] = "done"
            new_queue.append(rec)
            continue
        except Exception as e:
            retry_count += 1
            rec["retry_count"] = retry_count
            rec["error"] = str(e)
            rec["failed_at"] = now_kst_iso()

            if retry_count >= max_retries:
                rec["status"] = "dead"
                append_jsonl(DEADLETTER_PATH, rec)
                # keep in queue as dead for traceability
                new_queue.append(rec)
            else:
                rec["status"] = "pending"
                new_queue.append(rec)

    write_jsonl_atomic(QUEUE_PATH, new_queue)
    print("DONE")
    return 0


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser()
    sub = p.add_subparsers(dest="cmd", required=True)

    e = sub.add_parser("enqueue")
    e.add_argument("--idempotency-key", required=True)
    e.add_argument("--job-type", required=True)
    e.add_argument("--payload-json", default="")
    e.add_argument("--failed-at", default="")
    e.add_argument("--error", default="")
    e.add_argument("--retry-count", default="0")
    e.add_argument("--status", default="pending")
    e.set_defaults(fn=cmd_enqueue)

    r = sub.add_parser("run-pending")
    r.add_argument("--max-retries", default="3")
    r.set_defaults(fn=cmd_run_pending)

    return p


def main(argv: List[str]) -> int:
    p = build_parser()
    args = p.parse_args(argv)
    return int(args.fn(args))


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
