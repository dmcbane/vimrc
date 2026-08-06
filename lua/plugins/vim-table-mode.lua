return {
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
		config = function()
			-- Configure table-mode to use Markdown-friendly pipe corners
			vim.g.table_mode_corner = "|"

			-- Create an autocommand to format and set settings on load
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				pattern = "*.md",
				callback = function()
					-- 1. Turn off line wrapping safely for this specific buffer only
					vim.b.wrap = false -- Sets buffer-scoped variable if needed
					vim.cmd("setlocal nowrap") -- Enforces buffer-local window styling context safely

					-- 2. Turn on automatic table tracking
					vim.cmd("TableModeEnable")

					-- 3. Scan and instantly align any existing unformatted tables
					vim.cmd("TableModeRealign")
				end,
			})
		end,
	},
}
