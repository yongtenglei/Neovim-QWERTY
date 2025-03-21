return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    --------------------------------lspconfig-----------------------
    local lspconfig = require("lspconfig")
    local util = require("lspconfig/util")

    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<space>E", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Hand formatting stuff to conform.nvim
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      vim.lsp.inlay_hint.enable(true, { bufnr })

      local signature_setup = {
        --hint_prefix = "🐼 ",
        --hint_prefix = "🐧 ",
        --hint_prefix = "🦔 ",
        hint_prefix = "🦫 ",
      }

      require("lsp_signature").on_attach(signature_setup, bufnr)

      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      -- telescope integration
      telescope_builtin = require("telescope.builtin")

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "B", vim.lsp.buf.hover, bufopts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
      vim.keymap.set("n", "<C-b>", vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)

      require("tiny-code-action").setup({
        -- backend = "vim",
        backend = "delta",
      })
      vim.keymap.set("n", "<leader>ca", function()
        require("tiny-code-action").code_action()
      end, bufopts)
      -- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)

      -- use telescope packer
      --vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      vim.keymap.set("n", "gr", telescope_builtin.lsp_references, bufopts)

      vim.keymap.set("n", "<space>F", function()
        vim.lsp.buf.format({ async = true })
      end, bufopts)
    end

    local lsp_flags = {
      -- This is the default in Nvim 0.7+
      debounce_text_changes = 150,
    }

    local lsp_defaults = lspconfig.util.default_config
    lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

    local servers = {
      "clangd",
      "pyright",
      "ruff",
      "rust_analyzer",
      "lua_ls",
      "cmake",
      "cssls",
      "vuels",
      "dockerls",
      "gopls",
      "html",
      "jsonls",
      "sqlls",
      "yamlls",
      "quick_lint_js",
      "texlab",
    }

    for _, lsp in pairs(servers) do
      if lsp == "lua_ls" then
        lspconfig[lsp].setup({
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
          on_attach = on_attach,
          flags = lsp_flags,
        })
      elseif lsp == "rust_analyzer" then
        lspconfig[lsp].setup({
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = true,
              check = { command = "clippy", features = "all" },
              assist = {
                importGranularity = "module",
                importPrefix = "self",
              },
              diagnostics = {
                enable = true,
                enableExperimental = true,
              },
              cargo = {
                loadOutDirsFromCheck = true,
                features = "all", -- avoid error: file not included in crate hierarchy
              },
              procMacro = {
                enable = true,
              },
              inlayHints = {
                chainingHints = true,
                parameterHints = true,
                typeHints = true,
              },
            },
          },
          on_attach = on_attach,
          flags = lsp_flags,
        })
      else
        lspconfig[lsp].setup({
          on_attach = on_attach,
          flags = lsp_flags,
        })
      end
    end
  end,
  dependencies = {
    { "ray-x/lsp_signature.nvim" },
    { "rachartier/tiny-code-action.nvim" },
  },
}
