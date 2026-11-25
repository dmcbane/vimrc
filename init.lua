-- ~/.config/nvim/init.lua — Neovim (Lua) entry point.
--
-- Migrated in 2026 from a Vimscript config (vimrc + settings/*, vim-plug)
-- that was shared with classic Vim; those files are retired (see git history).
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
