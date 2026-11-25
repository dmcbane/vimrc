-- lua/plugins/git.lua — git integration.
-- Keeps tpope/vim-fugitive (best-in-class :Git command UI) and adds
-- gitsigns.nvim for gutter signs, hunk actions, and inline blame.
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Git: " .. desc })
        end
        -- navigate hunks (nav_hunk is the current API; next_hunk/prev_hunk are deprecated)
        map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Previous hunk")
        -- stage / reset / preview
        map({ "n", "v" }, "<leader>hs", gs.stage_hunk, "Stage hunk")
        map({ "n", "v" }, "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>hd", gs.diffthis, "Diff this")
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Gblame", "Gclog" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status (fugitive)" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame (fugitive)" },
    },
  },
}
