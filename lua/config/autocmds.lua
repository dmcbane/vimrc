-- lua/config/autocmds.lua — autocommands.
-- Ported from settings/tabs.vim (per-filetype indentation).
-- Note: format-on-save (was settings/elixir.vim's `mix format`) is handled by
-- conform.nvim in lua/plugins/format.lua, not here.

local function augroup(name)
  return vim.api.nvim_create_augroup("dale_" .. name, { clear = true })
end

-- ── Per-filetype indentation ─────────────────────────────────────────────
-- Effective rules from tabs.vim, made internally consistent (softtabstop is
-- set explicitly so <Tab> and >> always agree).
local indent_by_ft = {
  html         = { tabstop = 2, shiftwidth = 2, softtabstop = 2 },
  ruby         = { tabstop = 2, shiftwidth = 2, softtabstop = 2 },
  javascript   = { tabstop = 4, shiftwidth = 4, softtabstop = 0 },
  coffeescript = { tabstop = 4, shiftwidth = 4, softtabstop = 0 },
  jade         = { tabstop = 4, shiftwidth = 4, softtabstop = 0 },
  -- Go was set to expandtab in tabs.vim; gofmt will re-tab on save (Phase 10).
  go           = { tabstop = 4, shiftwidth = 4, softtabstop = 4 },
}

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("indent"),
  pattern = vim.tbl_keys(indent_by_ft),
  callback = function(args)
    for option, value in pairs(indent_by_ft[args.match]) do
      vim.bo[option] = value
    end
    vim.bo.expandtab = true
  end,
})

-- ── Briefly highlight yanked text (modern nicety, non-intrusive) ─────────
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})
