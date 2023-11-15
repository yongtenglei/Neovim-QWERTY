return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local actions = null_ls.builtins.code_actions
    local hover = null_ls.builtins.hover

    local sources = {
      formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
      formatting.black.with({ extra_args = { "--fast" } }),
      formatting.stylua,
      formatting.goimports,
      formatting.gofumpt,
      formatting.rustfmt,
      formatting.forge_fmt,

      diagnostics.flake8.with({ extra_args = { "--ignore=E501" } }),
      diagnostics.pylint.with({ extra_args = { "--disable=line-too-long" } }),
      diagnostics.golangci_lint,
      --diagnostics.solhint,

      actions.gitsigns,

      hover.dictionary,
    }

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ timeout_ms = 2000 })
            end,
          })
        end
      end,
    })
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
