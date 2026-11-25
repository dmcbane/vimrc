-- lua/plugins/neo-tree.lua — file-explorer drawer.
-- Replaces NERDTree (settings/nerdtree.{plug,vim}) and the netrw project-drawer
-- (settings/netrw.vim) for Neovim, preserving the auto-open / auto-close feel.
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle left<cr>", desc = "Explorer toggle" },
    { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Explorer reveal current file" },
  },
  init = function()
    -- Open the drawer on startup when nvim is launched with no file arguments
    -- (replaces the NERDTree/netrw VimEnter autocmds). Guards preserved:
    --   * skip when piping into nvim via stdin (StdinReadPre)
    --   * skip under VimR (g:gui_vimr)
    local group = vim.api.nvim_create_augroup("dale_neotree_autostart", { clear = true })
    local from_stdin = false
    vim.api.nvim_create_autocmd("StdinReadPre", {
      group = group,
      callback = function()
        from_stdin = true
      end,
    })
    vim.api.nvim_create_autocmd("VimEnter", {
      group = group,
      callback = function()
        if vim.fn.argc() == 0 and not from_stdin and not vim.g.gui_vimr then
          require("neo-tree.command").execute({ action = "show", position = "left" })
        end
      end,
    })
  end,
  opts = {
    close_if_last_window = true, -- quit nvim if neo-tree is the last window
    filesystem = {
      follow_current_file = { enabled = true }, -- keep the tree synced to the buffer
      hijack_netrw_behavior = "open_default", -- take over directory opens from netrw
      use_libuv_file_watcher = true, -- refresh on external file changes
    },
    window = {
      position = "left",
      width = 30,
    },
  },
}
