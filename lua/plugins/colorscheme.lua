-- lua/plugins/colorscheme.lua — colorscheme selection.
--
-- Preferred: base16-nvim driven by matugen (wallpaper-derived palette).
--   matugen writes lua/matugen.lua (gitignored, per-machine) and sends
--   SIGUSR1 on changes; lua/matugen.lua re-applies itself on that signal.
-- Fallback: onedarkpro's "onedark" on machines without lua/matugen.lua.
--
-- Exactly one of the two applies a colorscheme, so nothing gets overridden.
return {
  {
    "olimorris/onedarkpro.nvim",
    lazy = false, -- colorschemes load during startup, not on demand
    priority = 1000, -- before everything else, so highlights are correct
    config = function()
      require("onedarkpro").setup({
        options = {
          cursorline = true, -- style the cursorline highlight
          highlight_inactive_windows = true,
        },
      })
    end,
  },
  {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 999, -- after onedarkpro's setup, still before other plugins
    config = function()
      local ok, matugen = pcall(require, "matugen")
      if ok then
        matugen.setup()
      else
        vim.cmd.colorscheme("onedark")
      end
    end,
  },
}
