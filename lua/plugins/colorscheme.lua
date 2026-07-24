-- lua/plugins/colorscheme.lua — onedarkpro.nvim (already Lua-native).
-- Replaces the old settings/colorscheme.{plug,vim} for Neovim.
return {
  "olimorris/onedarkpro.nvim",
  lazy = false, -- a colorscheme should load during startup, not on demand
  priority = 1000, -- ...and before other plugins, so highlights are correct
  config = function()
    require("onedarkpro").setup({
      options = {
        cursorline = true, -- style the cursorline highlight
        highlight_inactive_windows = true,
      },
    })
    vim.cmd.colorscheme("onedark")
  end,
}
