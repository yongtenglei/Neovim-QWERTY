return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "ruff", "bandit", "mypy" },
        markdown = { "markdownlint" },
        golang = { "golangcilint" },
        javascript = { "eslint" },
        html = { "eslint" },
        css = { "stylelint" },
        json = { "jsonlint" },
        dockerfile = { "hadolint" },
        text = { "vale" },
      }

      lint.linters_by_ft["clojure"] = nil
      lint.linters_by_ft["inko"] = nil
      lint.linters_by_ft["janet"] = nil
      lint.linters_by_ft["rst"] = nil
      lint.linters_by_ft["ruby"] = nil
      lint.linters_by_ft["terraform"] = nil

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
