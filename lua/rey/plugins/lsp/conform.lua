return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },

        python = { "ruff_organize_imports", "ruff_fix", "autopep8" },

        go = { "gofumpt", "goimports", "golines" },

        markdown = { "mdformat" },

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
        return { timeout_ms = 500, lsp_fallback = false }
      end,

      formatters = {
        autopep8 = {
          prepend_args = { "--max-line-length", "200" },
        },
      },
    })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
