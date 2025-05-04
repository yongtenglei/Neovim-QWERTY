return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      python = { "ruff", "bandit", "mypy" },
      markdown = { "markdownlint" },
      golang = { "golangcilint" },
      javascript = { "eslint" },
      html = { "eslint" },
      css = { "stylelint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
