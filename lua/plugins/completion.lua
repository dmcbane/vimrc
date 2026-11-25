-- lua/plugins/completion.lua — completion engine (blink.cmp).
-- Fills the completion vacuum left when coc.nvim/deoplete were removed.
-- Pinning to a released 1.x tag downloads a prebuilt fuzzy-matcher binary,
-- so no Rust toolchain is required.
return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  opts = {
    -- default preset: <C-space> open, <C-y> accept, <C-n>/<C-p> select,
    -- <C-e> cancel, <Tab>/<S-Tab> jump snippet fields.
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
