# Vim-config self-auditing harness

A recurring agent that periodically (a) finds **better tools** and (b) re-evaluates
the **loading/management approach** of this Vim/Neovim config against what Neovim
now makes possible — then auto-applies safe changes and proposes the rest for review.

This README is both the operating manual and a short explanation of *how* the
harness is built, so you can change it confidently.

---

## The pieces and why each exists

| Piece | File | Role |
|-------|------|------|
| **Subagent** (the worker) | `.claude/agents/vim-config-auditor.md` | All the expertise + the audit procedure. Reusable; invoked by both the schedule and the manual command. |
| **Skill** (manual entry) | `.claude/skills/vim-audit/SKILL.md` | `/vim-audit` — a thin invoker so you can run it on demand and test before scheduling. |
| **Ledger** (memory) | `.claude/vim-audit/history.md`, `decisions.md` | Persistent, repo-committed memory so runs don't repeat themselves and respect your accept/reject choices. |
| **Reports** | `.claude/vim-audit/reports/<YYYY>-Q<N>.md` | Human-readable output, one per run. |
| **Validation gate** (safety) | `.claude/vim-audit/validate.sh` | Boots the config headless; auto-apply is allowed only on a green gate. |
| **Guard hook** (optional) | `.claude/vim-audit/protect-preserved.sh` | Opt-in hard stop on edits to preserved hand-written code. |
| **Routine** (the loop) | created via `/schedule` | Unattended quarterly cloud run that clones the repo and invokes the subagent. |

### Concepts in one paragraph
The **routine** is the "loop": a scheduled cloud agent that runs unattended, clones
this repo, and invokes the **subagent**. The subagent does the thinking — it reads
the **ledger** (memory across runs), inventories the live config, does **live web
research** (so "better tools" reflects today's ecosystem, not stale knowledge),
diffs against the ledger, and classifies findings. Low-risk changes are applied and
then **validated** (headless boot) before any merge; riskier changes become review
PRs. Because each cloud run is a fresh clone, all state lives **in the repo**.

---

## Autonomy model (as you chose)

- **Low-risk → auto-apply, gated.** ONLY additive/inherently-reversible changes:
  version pins, lockfile/`:PlugSnapshot`, typo/comment fixes. Applied on a `claude/`
  branch; merges to `main` only if `validate.sh` returns 0. A failed gate downgrades
  it to a review PR. **No file removal is ever auto-apply** — a green gate proves the
  config still boots, not that a deletion was wanted.
- **Riskier → review PR only.** All file removals (incl. `*.vim_saved` and
  historical files like `autostart/plug.vim`), branch pruning, plugin swaps,
  LSP/completion migration, vim-plug→lazy/Lua, Vimscript→Lua, anything touching
  preserved code. You merge or close.
- **Never touched:** `TwiddleCase`, `SourceDirectory`, `EditInitFiles`/`ReloadVimrc`,
  Elixir `mix format` on save, per-filetype indents, NERDTree autocmds, the vim-plug
  bootstrap. (Listed in the subagent + the optional guard hook.)

---

## How to run it

### 1. Dry run (do this first — no changes made)
In a Claude Code session in this repo:

```
/vim-audit report-only
```

Confirm it produces a sane `reports/<...>.md`, cites current sources, suppresses the
seeded baseline findings appropriately, and makes **no** edits. (Or run the worker
directly: `claude --agent vim-config-auditor` then ask for a report-only audit.)

### 2. Verify the gate yourself (already verified once on setup)
```
bash .claude/vim-audit/validate.sh        # expect: GATE PASS, exit 0
```

### 3. Record your decisions
After the first report, add accept/reject/defer entries to `decisions.md`. The
auditor treats **rejected** as permanent and stops re-suggesting it.

### 4. Schedule the quarterly routine (the unattended loop)
This step is yours to run — a scheduled cloud agent can't be created from here.

```
/schedule
```

Configure it with:
- **Cadence:** quarterly — cron `0 10 1 1,4,7,10 *` (10:00 on the 1st of Jan/Apr/Jul/Oct).
- **Repo:** `dmcbane/vimrc` (GitHub must be connected; routine clones the default branch).
- **Network:** enabled (Trusted domains is enough for plugin/registry research).
- **Prompt:**
  > Invoke the vim-config-auditor subagent to audit this repo per its instructions:
  > read the ledger, inventory the live config, research current best-in-class Neovim
  > tooling and management approaches, diff vs the ledger, auto-apply gated low-risk
  > changes (merge only on a green `.claude/vim-audit/validate.sh`), open review PRs
  > for riskier items, write the quarterly report, and update history.md. Before any
  > auto-merge, install Neovim in the sandbox so the gate can run.

### 5. Consume results each quarter
- Read the latest `reports/<YYYY>-Q<N>.md`.
- Review/merge any open `claude/vim-audit-*` PRs on GitHub.
- `git pull` in `~/.vim` to pick up auto-merged low-risk changes.
- Update `decisions.md` with anything you accept or reject.

---

## Important caveats

- **The routine evaluates the *committed* config**, not your live `~/.vim`. Push
  local changes before relying on a scheduled run.
- **Web research is the load-bearing capability.** If it's unavailable in a run, the
  report will flag tool-currency claims as unverified rather than guess.
- **Claude Code syntax is version-dependent** (agent/skill frontmatter, hook schema,
  `/schedule` flags). If a piece doesn't load, check `/agents`, `/schedule`, and the
  docs for your installed version and adjust.
- **Widening auto-apply** is a one-line change in the subagent's classification step —
  but keep the validation gate in front of any auto-merge.
