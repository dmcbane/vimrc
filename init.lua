-- ~/.config/nvim/init.lua — Neovim (Lua) entry point.
--
-- This repository is shared between classic Vim and Neovim:
--   * classic Vim  loads  ~/.vim/vimrc        (Vimscript, unchanged)
--   * Neovim       loads  this file           (Lua, modern stack)
--
-- The old Neovim bridge `init.vim` (which just sourced `vimrc`) has been
-- retired here — Neovim cannot have both init.vim and init.lua (E5422).
-- Migration tracked as finding B5 in .claude/vim-audit/.
--
-- Structure:
--   lua/config/options.lua   editor options   (was vimrc + settings/tabs.vim)
--   lua/config/keymaps.lua   key mappings      (was vimrc + settings/*)
--   lua/config/autocmds.lua  autocommands      (was settings/*.vim)
--   lua/config/lazy.lua      plugin manager bootstrap
--   lua/plugins/*.lua        one spec (group) per plugin, loaded by lazy.nvim

-- The leader must be set before lazy.nvim loads, so that plugin mappings
-- defined during startup pick up the right leader key.
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
