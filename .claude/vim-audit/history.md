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
| B1 | No Neovim native LSP configured; `coc.nvim` declared (`vimrc:109`, `release`) but its module is disabled (`settings/coc.vim_saved`). | management | riskier | **implemented** | 2026-06-23: coc.nvim fully removed (moved to `coc.plug_saved`). Completion vacuum is now clean. |
| B2 | `ALE` active (`vimrc:97`) but no linters configured in active modules (only in `*_saved`). | tools | riskier | **implemented** | 2026-06-23: ALE fully removed (moved to `rails.plug_saved`/`clojure.plug_saved`). Linting vacuum is now clean. |
| B3 | No fuzzy finder — `fzf` (`vimrc:92`) and `vim-clap` (`vimrc:121`) both `""`/`"`-commented. | tools | riskier | **implemented** | 2026-06-23: `vim-clap` now active in `settings/fuzzy.plug`. |
| B4 | No lockfile / snapshot; only `coc.nvim` pinned. `:PlugUpdate` is non-reproducible. | management | low-risk | open | 2026-06-23: still open; sandbox couldn't install plugins to generate snapshot. Owner: run `:PlugSnapshot ~/.vim/vim-plug-snapshot.vim` locally. |
| B5 | Config is 100% Vimscript; no Lua despite Neovim-primary usage. | management | riskier | open | Standing north-star. vim.pack not available in 0.11.1 (requires 0.12). |
| B6 | `NERDTree` active (`vimrc:91`) + `vim-vinegar`/netrw fallback. | tools | riskier | open | Low urgency. NEVER-TOUCH autocmds intact. |
| B7 | `lightline.vim` active (`vimrc:114`). | tools | riskier | **changed** | 2026-06-23: lightline.vim now disabled in `settings/lightline.plug`; see N5. |
| B8 | `*.vim_saved` modules: coc, clojure, common-lisp, deoplete, diff, rails, zettelkasten, neovide. | tools | riskier | rejected | **KEEP** — the `.vim_saved` rename is the owner's OFF-switch convention (see decisions.md). Never auto-delete; review-PR only. |
| B9 | Stale remote branches: `clojure/{linux,windows}`, `elm/{linux,windows}` (3–5 yrs old). | management | riskier | open | 2026-06-23: confirmed still present on remote via GitHub API. Owner must confirm before deletion. |
| B10 | `autostart/plug.vim` — historical duplicate of `autoload/plug.vim`. | management | riskier | rejected | **KEEP** — deliberately restored in commit dcb6e34 (see decisions.md). Never auto-delete. |

---

## New findings — 2026-06-19 DRY-RUN

| # | Finding | Track | Risk | Status | Notes |
|---|---------|-------|------|--------|-------|
| N1 | `coc.nvim` loaded but inert (combine with B1). | management | riskier | **obsolete** | 2026-06-23: coc removed; no longer applicable. |
| N2 | `vim.pack` (Neovim built-in) changes north-star math. | management | riskier | open | 2026-06-23: vim.pack is Neovim 0.12+; sandbox has 0.11.1. Still a standing item. |
| N3 | Stray duplicate files: `settings/neovide.vim_saved` duplicates active `neovide.vim`; `autoload/plug.vim.old` and `autostart/plug.vim` are stale plug copies. | management | low-risk | **partial** | 2026-06-23: `settings/neovide.vim_saved` removed in commit `9eb3371`. `autostart/plug.vim` kept per B10/decisions.md. `autoload/plug.vim.old` not found in fresh clone (may have been cleaned up). |

---

## New findings — 2026-06-23 FULL RUN

| # | Finding | Track | Risk | Status | Notes |
|---|---------|-------|------|--------|-------|
| N4 | `lifepillar/vim-gruvbox8` **ARCHIVED March 11, 2026** — active colorscheme is read-only, no more updates. | tools | riskier | proposed | Proposed replacements in 2026-Q2 report §6 PR1: `sainnhe/gruvbox-material` (Vim+Neovim) or `ellisonleao/gruvbox.nvim` (Neovim-only). |
| N5 | `itchyny/lightline.vim` disabled in `settings/lightline.plug` but `shinchu/lightline-gruvbox.vim` still active and `settings/lightline.vim` still configures lightline. Plain statusline in effect; dead weight in config. | tools | riskier | proposed | Options in 2026-Q2 report §6 PR2: re-enable lightline, remove entirely, or migrate to lualine. |
| N6 | `gpanders/vim-oldfiles` now active; plugin appears dormant (32 stars, last issues 2021). | tools | low | open | Still functional. Monitor. Built-in `:oldfiles` is the alternative. |
| N7 | `mattn/emmet-vim` appears stale (120+ open issues, no confirmed recent release). | tools | low | open | Still functional. Revisit with LSP decision (emmet-language-server). |

---

## Auto-applied — 2026-06-23

| # | Change | Gate | Pushed |
|---|--------|------|--------|
| vimrc comments/typo | Fixed typo "noticible"→"noticeable"; updated two stale coc-era comments. Committed as `c7800ea` on branch `claude/vim-audit-q3-low-risk`, merged to local `main`. | PASS | **No** — 403 from scheduled-environment git proxy. Owner must push manually. |
