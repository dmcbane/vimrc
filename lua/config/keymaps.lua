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

-- 1. Ensure OS detection and key variables are defined at the top
local is_mac = vim.fn.has("macunix") == 1
local paste_key = is_mac and "<D-v>" or "<C-S-v>"
local copy_key = is_mac and "<D-c>" or "<C-S-c>"

-- 2. Paste in Insert and Command modes
vim.keymap.set({ "i", "c" }, paste_key, "<C-R>+", { desc = "Paste from clipboard" })

-- 3. Paste in Normal and Visual modes
vim.keymap.set({ "n", "v" }, paste_key, '"+p', { desc = "Paste from clipboard" })

-- 4. Paste in Terminal mode (Fixes the nil error)
if is_mac then
	vim.keymap.set("t", paste_key, [[<C-\><C-o>"+p]], { desc = "Paste from clipboard in terminal" })
else
	vim.keymap.set("t", paste_key, [[<C-\><C-n>"+Pi]], { desc = "Paste from clipboard in terminal" })
end

-- Copy selected text in Visual mode to the system clipboard
vim.keymap.set("v", copy_key, '"+y', { desc = "Copy to clipboard" })
