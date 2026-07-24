-- lua/plugins/markdown.lua — markdown editing.
-- vim-markdown's syntax is now handled by treesitter (lua/plugins/treesitter.lua).
-- This keeps browser preview and adds in-buffer rendering.
-- (Emmet for web is handled by emmet_language_server in lua/plugins/lsp.lua.)
return {
  -- In-buffer rendering of headings, code blocks, tables, checkboxes, etc.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    opts = {},
  },
  -- Live preview in the browser (was settings/markdown.plug).
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview toggle" },
    },
  },
}
