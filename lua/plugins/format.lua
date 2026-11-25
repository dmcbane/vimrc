-- lua/plugins/format.lua — formatting via conform.nvim.
-- Replaces the synchronous `mix format` BufWritePre autocmd (settings/elixir.vim)
-- with async, multi-language format-on-save. Missing formatters fall back to
-- LSP formatting; :ConformInfo reports what actually ran.
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer/selection",
    },
  },
  opts = {
    formatters_by_ft = {
      elixir = { "mix_format" }, -- was settings/elixir.vim
      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      html = { "prettier" },
      css = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
    -- Format on save, unless disabled via :FormatDisable (see below).
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return nil
      end
      return { timeout_ms = 3000, lsp_format = "fallback" }
    end,
  },
  config = function(_, opts)
    require("conform").setup(opts)

    -- Toggle format-on-save globally (:FormatDisable!) or per-buffer.
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { bang = true, desc = "Disable format-on-save (! = current buffer)" })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Re-enable format-on-save" })
  end,
}
