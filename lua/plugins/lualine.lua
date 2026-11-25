local function selection_char_count()
	-- Check if we are in visual mode
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" or mode == "\22" then -- \22 is Ctrl-V blockwise
		local wc = vim.fn.wordcount()
		if wc.visual_chars ~= nil then
			return wc.visual_chars .. " chars"
		end
	end
	return ""
end

-- lua/plugins/lualine.lua — statusline. Replaces the (disabled) lightline setup.
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		-- Hex value of the character under the cursor (was lightline's `0x%B`).
		local function char_hex()
			local col = vim.fn.col(".")
			local line = vim.api.nvim_get_current_line()
			if col > #line then
				return ""
			end
			local codepoint = vim.fn.char2nr(line:sub(col)) -- char2nr handles UTF-8
			if codepoint == 0 then
				return ""
			end
			return string.format("0x%X", codepoint)
		end

		require("lualine").setup({
			options = {
				theme = "auto", -- derive colors from the active colorscheme (onedark)
				globalstatus = true, -- single statusline (pairs with laststatus=3)
				section_separators = "",
				component_separators = "|",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						path = 1, -- relative path
						symbols = { modified = " ●", readonly = " ", newfile = " " },
					},
				},
				lualine_x = { selection_char_count, "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
