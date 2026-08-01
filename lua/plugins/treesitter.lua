-- lua/plugins/treesitter.lua — syntax highlighting & indentation via Tree-sitter.
-- Modern replacement for the syntax bundled in vim-elixir, vim-go, vim-markdown.
--
-- Note: Migrated to the `main` branch due to Neovim 0.12+ API compatibility.
-- Uses `nvim-treesitter.config` instead of the legacy `.configs` module.
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdate", "TSUpdateSync", "TSInstall", "TSInstallInfo" },
	config = function()
		-- Changed from "nvim-treesitter.configs" to "nvim-treesitter.config"
		require("nvim-treesitter.config").setup({
			ensure_installed = {
				-- elixir ecosystem (was vim-elixir)
				"elixir",
				"eex",
				"heex",
				-- go ecosystem (was vim-go)
				"go",
				"gomod",
				"gosum",
				"gowork",
				-- markdown (was vim-markdown)
				"markdown",
				"markdown_inline",
				-- web
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				-- this config + docs
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
				"query",
				-- general
				"bash",
				"json",
				"jsonc",
				"yaml",
				"toml",
				"regex",
				"diff",
				"gitcommit",
				"gitignore",
			},
			auto_install = true, -- install a missing parser when its filetype opens
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}