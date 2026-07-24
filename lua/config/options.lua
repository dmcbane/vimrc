-- lua/config/options.lua — editor options.
-- Ported from vimrc + settings/tabs.vim. Fully populated in Phase 1;
-- for now just the essentials the colorscheme depends on.

local opt = vim.opt

-- True-color in the terminal (Neovim enables it by default in most terminals,
-- but set it explicitly to match the old `set termguicolors`).
opt.termguicolors = true

-- Highlight the current line and column (was `set cursorline` / `cursorcolumn`).
opt.cursorline = true
opt.cursorcolumn = true

opt.background = "dark"
