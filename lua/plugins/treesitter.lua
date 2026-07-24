-- lua/plugins/treesitter.lua — syntax highlighting & indentation via Tree-sitter.
-- Modern replacement for the syntax bundled in vim-elixir, vim-go, vim-markdown.
--
-- Pinned to the `master` branch: the repo default is now the `main` rewrite,
-- which uses a different, more manual API. `master` remains supported and keeps
-- the batteries-included module setup below. Migrating to `main` is a future
-- item (worth an audit note) once its highlight/indent story fully stabilizes.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdate", "TSUpdateSync", "TSInstall", "TSInstallInfo" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        -- elixir ecosystem (was vim-elixir)
        "elixir", "eex", "heex",
        -- go ecosystem (was vim-go)
        "go", "gomod", "gosum", "gowork",
        -- markdown (was vim-markdown)
        "markdown", "markdown_inline",
        -- web
        "html", "css", "javascript", "typescript", "tsx",
        -- this config + docs
        "lua", "luadoc", "vim", "vimdoc", "query",
        -- general
        "bash", "json", "jsonc", "yaml", "toml", "regex",
        "diff", "gitcommit", "gitignore",
      },
      auto_install = true, -- install a missing parser when its filetype opens
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
