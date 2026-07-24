-- lua/config/keymaps.lua — global key mappings and small helper functions.
-- Leader ("," / ",") is set in init.lua before this file loads.
-- Plugin-specific maps live with their plugin spec in lua/plugins/.

local map = vim.keymap.set

-- ── TwiddleCase: cycle a visual selection lower -> Title -> UPPER ─────────
-- Faithful port of the Vimscript TwiddleCase() + visual `~` mapping.
local function twiddle_case(str)
  if str == str:upper() then
    return str:lower()
  elseif str == str:lower() then
    -- Title Case: uppercase the first char of each word, leave the rest as-is
    -- ([%w_]+ matches Vim's \w, which includes the underscore).
    return (str:gsub("[%w_]+", function(word)
      return word:sub(1, 1):upper() .. word:sub(2)
    end))
  else
    return str:upper()
  end
end

map("x", "~", function()
  vim.cmd("normal! y") -- yank the selection into the unnamed register
  vim.fn.setreg('"', twiddle_case(vim.fn.getreg('"')), vim.fn.getregtype('"'))
  vim.cmd('normal! gv""Pgv') -- paste it back over the reselected text
end, { desc = "Cycle case of selection (lower/Title/UPPER)" })

-- ── Edit the Neovim config files ─────────────────────────────────────────
-- Modernized EditInitFiles: opens init.lua plus every file under lua/ in tabs.
local function edit_init_files()
  local config = vim.fn.stdpath("config")
  vim.cmd.edit(config .. "/init.lua")
  local files = vim.fn.globpath(config .. "/lua", "**/*.lua", false, true)
  table.sort(files)
  for _, file in ipairs(files) do
    vim.cmd.tabnew(vim.fn.fnameescape(file))
  end
  vim.cmd.tabfirst()
end

vim.api.nvim_create_user_command("EditInitFiles", edit_init_files, {
  desc = "Open all Neovim Lua config files in tabs",
})
map("n", "<leader>v", edit_init_files, { desc = "Edit Neovim config files" })
