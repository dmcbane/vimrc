# Vim-config audit — owner decisions

**You own this file. The auditor only reads it.** Record what you accept, reject,
or defer, and *why*. The auditor treats `rejected` as permanent and will stop
re-suggesting it. Reference findings by their id from `history.md` (B1, B2, …) or a
finding title.

Format one entry per decision:

```
### <id or title> — <accepted | rejected | deferred>  (YYYY-MM-DD)
Reason: <your reasoning — this is what stops the auditor from re-litigating it>
```

---

### .vim_saved files are INTENTIONALLY RETAINED — never auto-delete  (2026-06-19)
Reason: Renaming `name.vim` → `name.vim_saved` is my deliberate OFF-switch
convention (disabled-but-kept-for-reference). All of them are git-tracked on
purpose. They are not "dead cruft". Removing any `*.vim_saved` is at most a
review-PR item I must approve — never an auto-apply. Applies to B8.

### autostart/plug.vim is INTENTIONALLY RETAINED — never auto-delete  (2026-06-19)
Reason: Commit dcb6e34 ("autostart plug - how did this disappear") shows I noticed
this file vanish and deliberately restored all 2877 lines. Grep-unused does not
mean unwanted. Never auto-delete; review-PR only if ever proposed. Applies to B10.

<!-- Add your own decisions below in the same format. The auditor treats `rejected`
     as permanent and stops re-suggesting it.

### B6 (NERDTree → oil.nvim) — rejected  (2026-06-19)
Reason: I like NERDTree's tree drawer and auto-open/close; not worth the churn.
-->

