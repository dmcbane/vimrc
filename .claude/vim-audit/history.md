# Vim-config audit — findings ledger

Append-only log of every finding the auditor has surfaced, with the date it was
first seen and its current status. The auditor reads this each run and suppresses
findings that are already here and unchanged. Statuses:
`open` · `auto-applied` · `proposed` (review PR) · `accepted` · `rejected` · `implemented` · `obsolete`.

Owner decisions and reasons live in `decisions.md` — this file is the auditor's memory.

---

## Baseline — seeded 2026-06-19 (from initial config exploration; not yet researched)

These are the known starting points so the first real run reports *changes*, not
the obvious. The auditor should verify each against the live config and current
ecosystem before acting.

| # | Finding | Track | Risk | Status | Notes |
|---|---------|-------|------|--------|-------|
| B1 | No Neovim native LSP configured; `coc.nvim` declared (`vimrc:109`, `release`) but its module is disabled (`settings/coc.vim_saved`). | management | riskier | open | Candidate: native LSP + nvim-cmp/blink.cmp. Costs Vim 8 compatibility. |
| B2 | `ALE` active (`vimrc:97`) but no linters configured in active modules (only in `*_saved`). | tools | riskier | open | Candidate: native diagnostics + nvim-lint/conform.nvim, or configure ALE. |
| B3 | No fuzzy finder — `fzf` (`vimrc:92`) and `vim-clap` (`vimrc:121`) both `""`/`"`-commented. | tools | riskier | open | Candidate: telescope.nvim or fzf-lua. |
| B4 | No lockfile / snapshot; only `coc.nvim` pinned. `:PlugUpdate` is non-reproducible. | management | low-risk | open | Candidate: vim-plug snapshot, or lazy.nvim lockfile if migrating. |
| B5 | Config is 100% Vimscript; no Lua despite Neovim-primary usage. | management | riskier | open | North-star item; weigh against shared vim+nvim vimrc. |
| B6 | `NERDTree` active (`vimrc:91`) + `vim-vinegar`/netrw fallback. | tools | riskier | open | Candidate: oil.nvim / nvim-tree.lua; or lean on netrw. Low urgency. |
| B7 | `lightline.vim` active (`vimrc:114`). | tools | riskier | open | Candidate: lualine.nvim (Lua-native). Cosmetic; low urgency. |
| B8 | `*.vim_saved` modules: coc, clojure, common-lisp, deoplete, diff, rails, zettelkasten, neovide. | tools | riskier | rejected | **KEEP** — the `.vim_saved` rename is the owner's OFF-switch convention (see decisions.md). Never auto-delete; review-PR only. |
| B9 | Stale remote branches: `clojure/{linux,windows}`, `elm/{linux,windows}` (3–5 yrs old). | management | riskier | open | Branch removal is destructive; review/confirm only, never auto. |
| B10 | `autostart/plug.vim` — historical duplicate of `autoload/plug.vim`. | management | riskier | rejected | **KEEP** — deliberately restored in commit dcb6e34 (see decisions.md). Never auto-delete. |

> Nothing above has been acted on. Only additive/reversible changes (pins,
> snapshots) are ever eligible for auto-apply. **No file removal is auto-apply** —
> B8/B10 are retained by owner decision; B9 (branch pruning) is review-only.
