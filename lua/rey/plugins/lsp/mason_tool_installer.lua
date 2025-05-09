return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  config = function()
    require("mason-tool-installer").setup({

      -- a list of all tools you want to ensure are installed upon
      -- start
      ensure_installed = {
        -- vim
        { "vim-language-server" },

        -- lua
        { "lua_ls" },
        { "stylua" },
        { "luacheck" },

        -- golang
        { "gopls" },
        { "golangci_lint_ls" },
        { "gofumpt" },
        { "gomodifytags" },
        { "gotests" },
        { "goimports" },
        { "golines" },
        { "impl" },

        -- python
        { "black" },
        { "pylint" },
        { "isort" },
        { "mypy" },
        { "ruff" },
        { "bandit" },
        { "basedpyright" },

        -- C/C++
        { "clangd" },
        { "cmake" },

        -- bash
        { "bash-language-server" },
        { "shellcheck" },
        { "shfmt" },

        -- sql
        { "sqlls" },
        -- install sql_formatter manually
        -- { "sql_formatter" },

        -- front end
        { "quick_lint_js" },
        { "cssls" },
        { "vuels" },
        { "html" },

        -- yaml
        { "yamlls" },
        { "yamlfmt" },

        -- json
        { "jsonls" },
        { "jq" },

        -- markdown
        { "mdformat" },
        { "markdownlint" },
      },

      auto_update = false,

      run_on_start = true,

      start_delay = 500, -- 3 second delay

      debounce_hours = 5, -- at least 5 hours between attempts to install/update
    })
  end,
}
