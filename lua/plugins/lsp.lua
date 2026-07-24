-- lua/plugins/lsp.lua — native LSP via mason + nvim-lspconfig.
-- Gives go-to-definition, hover, rename, code actions, diagnostics — the
-- features coc.nvim used to provide, now through Neovim's built-in LSP client.
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "saghen/blink.cmp", -- for completion capabilities
  },
  config = function()
    -- Language servers to install and enable. Covers the languages the old
    -- config cared about: Go (was vim-go), Elixir (was vim-elixir), web
    -- (emmet — audit N7), plus Lua for editing this config itself.
    local servers = {
      "lua_ls",
      "gopls",
      "elixirls",
      "html",
      "cssls",
      "ts_ls",
      "jsonls",
      "emmet_language_server",
    }

    require("mason").setup()

    -- Apply blink.cmp completion capabilities to every server.
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- Server-specific settings.
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } }, -- don't flag the vim global
          workspace = { checkThirdParty = false },
        },
      },
    })

    -- Install (if missing) and auto-enable the servers above.
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_enable = true,
    })

    -- Buffer-local keymaps, set when a server attaches.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("dale_lsp_attach", { clear = true }),
      callback = function(ev)
        local function map(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gr", vim.lsp.buf.references, "References")
        map("gI", vim.lsp.buf.implementation, "Go to implementation")
        map("K", vim.lsp.buf.hover, "Hover documentation")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
        map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
        map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
      end,
    })

    -- Readable diagnostics: show signs in the gutter and virtual text inline.
    vim.diagnostic.config({
      virtual_text = true,
      severity_sort = true,
    })
  end,
}
