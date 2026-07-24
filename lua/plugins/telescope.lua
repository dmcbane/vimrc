-- lua/plugins/telescope.lua — fuzzy finder.
-- Replaces vim-clap (settings/fuzzy.plug) and vim-oldfiles
-- (settings/recentfiles.{plug,vim}); oldfiles becomes just another picker.
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<esc>"] = actions.close }, -- single Esc closes the picker
        },
      },
    })
    -- Load the compiled fzf sorter; if it wasn't built, say so rather than
    -- silently degrading to the slower Lua sorter.
    local ok, err = pcall(telescope.load_extension, "fzf")
    if not ok then
      vim.notify(
        "telescope-fzf-native not available (using Lua sorter): " .. tostring(err),
        vim.log.levels.WARN
      )
    end
  end,
}
