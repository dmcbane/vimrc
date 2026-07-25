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
    -- Live preview in the browser
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function(plugin)
            vim.cmd("lazy load markdown-preview.nvim")
            vim.fn["mkdp#util#install"]()
        end,
    }
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --     ft = { "markdown" },
    --     build = "cd app && npm install",
    -- }
}
