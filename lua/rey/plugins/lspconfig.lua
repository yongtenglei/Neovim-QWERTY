-- LSP Plugins
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "mason-org/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
      { "ray-x/lsp_signature.nvim" },
      { "saghen/blink.cmp" },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("B", vim.lsp.buf.hover, "Documentation")
          map("<space>E", vim.diagnostic.open_float, "Diaglostic Float Window")
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
          map("<leader>r", require("telescope.builtin").lsp_references, "Goto [R]eferences")
          map("<leader>i", require("telescope.builtin").lsp_implementations, "Goto [I]mplementation")

          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

          map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
          map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          --- Signature
          local signature_setup = {
            --hint_prefix = "🐼 ",
            --hint_prefix = "🐧 ",
            --hint_prefix = "🦔 ",
            hint_prefix = "🦫 ",
          }
          require("lsp_signature").on_attach(signature_setup, event.buf)

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            --- Inlay hint
            vim.lsp.inlay_hint.enable(true, { event.buf })

            require("lsp_signature").on_attach(signature_setup, event.buf)
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end

          -- Hand formatting stuff to conform.nvim
          if client then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        update_in_insert = false,
        signs = vim.g.have_nerd_font
            and {
              text = {
                -- [vim.diagnostic.severity.ERROR] = "󰅚 ",
                -- [vim.diagnostic.severity.WARN] = "󰀪 ",
                -- [vim.diagnostic.severity.INFO] = "󰋽 ",
                -- [vim.diagnostic.severity.HINT] = "󰌶 ",

                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                -- [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
              },
            }
          or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        clangd = {},
        basedpyright = {},
        ruff = {},
        rust_analyzer = {},
        lua_ls = {},
        cmake = {},
        cssls = {},
        docker_compose_language_service = {},
        dockerls = {},
        gopls = {},
        golangci_lint_ls = {},
        html = {},
        jsonls = {},
        sqlls = {},
        yamlls = {},
        quick_lint_js = {},
        texlab = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
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
        { "sql-formatter" },

        -- front end
        { "quick_lint_js" },
        { "cssls" },
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

        -- latex
        { "texlab" },

        -- docker
        { "dockerfile-language-server" },
        { "docker-compose-language-service" },
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
