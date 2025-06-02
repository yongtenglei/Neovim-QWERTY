-- Diagnostics
local config = {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      -- [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
}
vim.diagnostic.config(config)

-- Lsp capabilities and on_attach
-- Here we grab default Neovim capabilities and extend them with ones we want on top
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}
capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- capabilities from blink.cmp
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

-- Disable the default keybinds
for _, bind in ipairs({ "grn", "gra", "gri", "grr" }) do
  pcall(vim.keymap.del, "n", bind)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- -- nightly has inbuilt completions, this can replace all completion plugins
    -- if client:supports_method("textDocument/completion", bufnr) then
    --   -- Enable auto-completion
    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end

    --- Disable semantic tokens
    client.server_capabilities.semanticTokensProvider = nil

    -- Hand formatting stuff to conform.nvim
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    --- Inlay hint
    vim.lsp.inlay_hint.enable(true, { bufnr })

    --- Signature
    local signature_setup = {
      --hint_prefix = "🐼 ",
      --hint_prefix = "🐧 ",
      --hint_prefix = "🦔 ",
      hint_prefix = "🦫 ",
    }
    require("lsp_signature").on_attach(signature_setup, bufnr)

    -- All the keymaps
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true }
    local function opt(desc, others)
      return vim.tbl_extend("force", opts, { desc = desc }, others or {})
    end

    vim.keymap.set("n", "<space>E", vim.diagnostic.open_float, opt())
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opt())
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opt())
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opt())

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opt())
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opt())
    vim.keymap.set("n", "B", vim.lsp.buf.hover, opt())
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opt())
    vim.keymap.set("n", "<C-b>", vim.lsp.buf.signature_help, opt())

    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opt())
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opt())
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opt())
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opt())
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opt())
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opt())

    -- use telescope packer
    local telescope_builtin = require("telescope.builtin")
    vim.keymap.set("n", "gr", telescope_builtin.lsp_references, opt())
    --vim.keymap.set("n", "gr", vim.lsp.buf.references, opt())

    -- Handle it to conform.nvim
    vim.keymap.set("n", "<space>F", function()
      vim.lsp.buf.format({ async = true })
    end, opt())
  end,
})

-- servers
local servers = {
  "clangd",
  "basedpyright",
  "ruff",
  "rust_analyzer",
  "lua_ls",
  "cmake",
  "cssls",
  "docker_compose_language_service",
  "dockerls",
  "gopls",
  "golangci_lint_ls",
  "html",
  "jsonls",
  "sqlls",
  "yamlls",
  "quick_lint_js",
  "texlab",
}
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- Improve LSPs UI
-- local icons = {
--   Class = " ",
--   Color = " ",
--   Constant = " ",
--   Constructor = " ",
--   Enum = " ",
--   EnumMember = " ",
--   Event = " ",
--   Field = " ",
--   File = " ",
--   Folder = " ",
--   Function = "󰊕 ",
--   Interface = " ",
--   Keyword = " ",
--   Method = "ƒ ",
--   Module = "󰏗 ",
--   Property = " ",
--   Snippet = " ",
--   Struct = " ",
--   Text = " ",
--   Unit = " ",
--   Value = " ",
--   Variable = " ",
-- }
--
-- local completion_kinds = vim.lsp.protocol.CompletionItemKind
-- for i, kind in ipairs(completion_kinds) do
--   completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
-- end
