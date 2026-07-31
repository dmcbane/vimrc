-- lua/config/options.lua — editor options.
--
-- Ported from vimrc, settings/tabs.vim, settings/guifonts.vim and
-- settings/neovide.vim. Options that are already Neovim defaults
-- (hidden, encoding=utf-8, backspace, filetype/syntax on, ...) are
-- intentionally omitted — a modern config states only what differs.

local opt = vim.opt

-- ── General ──────────────────────────────────────────────────────────────
opt.clipboard = "unnamedplus" -- use the system clipboard for all yank/put
opt.updatetime = 300 -- faster CursorHold / swap write (LSP, gitsigns)
opt.path:append("**") -- let :find search recursively from cwd
opt.mouse = "a" -- mouse in all modes (Neovim default; explicit here)

-- ── Indentation ──────────────────────────────────────────────────────────
-- Effective values after vimrc + tabs.vim: 4-space soft tabs, expandtab.
-- Per-filetype overrides (html/ruby = 2, go = tabs) live in autocmds.lua.
opt.expandtab = true -- tabs become spaces
opt.tabstop = 4 -- a literal tab renders as 4 columns
opt.softtabstop = 4 -- <Tab>/<BS> operate on 4 columns
opt.shiftwidth = 4 -- >> / << and autoindent use 4 columns
opt.smartindent = true -- sensible autoindent for new lines

-- ── UI ───────────────────────────────────────────────────────────────────
opt.termguicolors = true -- 24-bit color (required by modern colorschemes)
opt.background = "dark"
opt.cursorline = true -- highlight the current line
opt.cursorcolumn = true -- highlight the current column
opt.signcolumn = "yes" -- always show the sign gutter (no text shift)
opt.cmdheight = 1 -- was 2 for coc.nvim; 1 is the modern default
opt.laststatus = 3 -- single global statusline (Neovim 0.7+; pairs with lualine)
opt.shortmess:append("c") -- don't show completion "match N of M" messages
opt.showtabline = 0 -- 0: never show, 1: show if >=2 tabs, 2: always show

-- ── Files / backups ──────────────────────────────────────────────────────
-- Some tools misbehave with backup files; keeping the original defaults.
opt.backup = false
opt.writebackup = false
-- Persistent undo is a strict upgrade over the old no-backup posture:
-- undo history survives closing a file. Stored under stdpath("state").
opt.undofile = true

-- ── GUI (Neovide, VimR, nvim-qt) ─────────────────────────────────────────
-- Terminals ignore guifont, so it is safe to set unconditionally.
opt.guifont = "JuliaMono Nerd Font,Hack Nerd Font,NotoMono Nerd Font,PT Mono:h16"

if vim.g.neovide then
	vim.g.neovide_cursor_vfx_mode = "railgun"
end
