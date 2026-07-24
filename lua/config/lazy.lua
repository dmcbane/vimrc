-- lua/config/lazy.lua — bootstrap and configure the lazy.nvim plugin manager.
-- Replaces vim-plug for Neovim. Plugins are declared as specs in lua/plugins/.
-- vim-plug (autoload/plug.vim + settings/*.plug) still serves classic Vim.

-- Clone lazy.nvim on first launch if it isn't installed yet.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    -- Never swallow the failure: show git's actual output and stop.
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Import every spec file under lua/plugins/.
  spec = {
    { import = "plugins" },
  },
  -- If a plugin's own colorscheme isn't available yet during install/update,
  -- fall back to these so the UI stays readable.
  install = { colorscheme = { "onedark", "habamax" } },
  -- Quietly check for plugin updates in the background.
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
