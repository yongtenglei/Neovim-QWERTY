return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },

        python = { "isort", "black" },

        go = { "gofumpt", "goimports", "golines" },

        markdown = { "mdformat" },

        ["sh"] = { "shfmt" },

        yaml = { "yamlfmt" },

        json = { "jq" },

        sql = { "sql_formatter" },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
