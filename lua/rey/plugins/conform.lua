return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },

          -- python = { "ruff_organize_imports", "ruff_fix", "autopep8" },
          python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },

          go = { "gofumpt", "goimports", "golines" },

          markdown = { "mdformat" },

          javascript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },

          ["sh"] = { "shfmt" },

          yaml = { "yamlfmt" },

          json = { "jq" },

          sql = { "sql_formatter" },
        },

        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          -- Only conform can take it!
          return { timeout_ms = 5000, lsp_fallback = false }
        end,
      })
    end,
  },
}
