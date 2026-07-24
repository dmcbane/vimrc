# Vim / Neovim configuration

One repository, two editors. The same directory is checked out as both
`~/.vim` (classic Vim) and `~/.config/nvim` (Neovim, via symlink).

| Editor      | Entry point | Plugin manager           | Language   |
|-------------|-------------|--------------------------|------------|
| Classic Vim | `vimrc`     | vim-plug (`autoload/`)   | Vimscript  |
| Neovim      | `init.lua`  | lazy.nvim (`lua/`)       | Lua        |

Classic Vim reads `vimrc` (it is the "2nd user vimrc file" in Vim's search
path) and loads plugins from `settings/*.plug`. Neovim reads `init.lua` and
loads the Lua plugin specs under `lua/plugins/`. The two stacks install to
separate directories and never collide.

> Neovim was migrated from Vimscript to Lua in 2026 (auditor finding B5).
> Classic Vim intentionally remains on the original Vimscript config.

## Neovim layout (`lua/`)

```
init.lua                 leader + require the config modules
lua/config/
  options.lua            editor options            (was vimrc + settings/tabs.vim)
  keymaps.lua            key mappings + TwiddleCase (was vimrc)
  autocmds.lua           filetype indent, yank hl   (was settings/*.vim)
  lazy.lua               lazy.nvim bootstrap
lua/plugins/
  colorscheme.lua        onedarkpro.nvim
  lualine.lua            statusline                 (replaced lightline)
  neo-tree.lua           file explorer              (replaced NERDTree/netrw)
  telescope.lua          fuzzy finder               (replaced vim-clap/vim-oldfiles)
  treesitter.lua         syntax + indent            (replaced vim-* syntax)
  lsp.lua                mason + LSP + tool installer
  completion.lua         blink.cmp
  format.lua             conform.nvim               (replaced mix-format autocmd)
  git.lua                gitsigns + fugitive
  markdown.lua           render-markdown + markdown-preview
```

## Requirements (Neovim)

- Neovim ≥ 0.11 (developed on 0.12)
- `git`, a C compiler (`cc`) and `make` — for lazy.nvim and fzf-native
- `ripgrep` and `fd` — telescope live-grep / find-files
- `node` and `go` — language servers install through mason
- A Nerd Font — icons in the statusline / explorer

On first launch, lazy.nvim installs the plugins and mason installs the
language servers and formatters (`gopls`, `elixirls`, `stylua`, `prettier`, …)
in the background. Run `:checkhealth` to confirm.

## Key mappings (leader = `,`)

| Keys          | Action                              |
|---------------|-------------------------------------|
| `<leader>v`   | Edit the Neovim config files        |
| `<leader>e`   | Toggle file explorer                |
| `<leader>ff`  | Find files                          |
| `<leader>fg`  | Live grep                           |
| `<leader>fr`  | Recent files                        |
| `<leader>fb`  | Buffers                             |
| `gd` / `gr`   | LSP go-to-definition / references   |
| `K`           | LSP hover                           |
| `<leader>ca`  | LSP code action                     |
| `<leader>rn`  | LSP rename                          |
| `<leader>cf`  | Format buffer/selection             |
| `]h` / `[h`   | Next / previous git hunk            |
| `<leader>gs`  | Git status (fugitive)               |
| `~` (visual)  | Cycle selection lower/Title/UPPER   |

Branches indicate machine/language variants (Windows/Linux/Rails/Go/CLISP/etc.).
