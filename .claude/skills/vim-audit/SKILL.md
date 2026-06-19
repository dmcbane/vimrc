---
name: vim-audit
description: >-
  Audit this Vim/Neovim config for modernization opportunities (better tools and
  a better loading/management approach) using live web research, a committed
  ledger to avoid repeats, gated auto-apply for low-risk changes, and review PRs
  for riskier proposals. Use when the user asks to audit/modernize/evaluate their
  vim or neovim configuration, or types /vim-audit. This is the manual entry point
  for the same procedure the quarterly routine runs.
---

# Vim config audit

Thin invoker. The expertise and full procedure live in the `vim-config-auditor`
subagent (`.claude/agents/vim-config-auditor.md`) so manual and scheduled runs
behave identically.

## What to do

Invoke the **vim-config-auditor** subagent (via the Agent tool, `subagent_type:
vim-config-auditor`).

**Local `/vim-audit` defaults to REPORT-ONLY.** The full autonomous flow
(auto-apply + branches + PRs + ledger writes) belongs to the cloud routine, which
runs against a fresh clone with `main` behind PR review and proper GitHub access.
Locally there is no `gh`/GitHub tool, so "open PRs" isn't really available, and
auto-merging the working tree's `main` is exactly the kind of change worth keeping
behind review. So unless the user *explicitly* asks to apply changes, run
report-only.

Default prompt to the subagent (report-only):

> Run in REPORT-ONLY mode. Make NO edits, branches, PRs, or ledger writes — the
> only file you may write is the report at `.claude/vim-audit/reports/<YYYY>-Q<N>.md`.
> Otherwise follow your full procedure: read the ledger, inventory the live config,
> research current best-in-class Neovim tooling AND management approaches, diff vs
> the ledger (honoring decisions.md rejections), classify findings, and for each
> note what you WOULD do. Return the structured summary.

## Arguments (optional)

- (default / `report-only` / `dry-run`) → the report-only behavior above.
- `apply` / `full` → run the full hybrid-autonomy flow locally **only if the user
  explicitly asked**. Even then, prefer local branches: auto-apply the additive
  low-risk change on a `claude/` branch, run `.claude/vim-audit/validate.sh`, and
  create local review branches for riskier items — do NOT push or auto-merge `main`
  without explicit confirmation. (For true unattended autonomy, use the cloud routine.)
- `tools-only` → restrict to per-tool findings; skip the management/north-star track.
- a topic (e.g. `lsp`, `fuzzy-finder`) → focus the research on that area this run.

## After it returns

Relay the subagent's structured summary to the user: counts, auto-applied changes
+ gate result, review PRs opened, the current north-star recommendation, and the
path to the full report. Remind the user to record accept/reject choices in
`.claude/vim-audit/decisions.md` so future runs respect them.
